import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  OrderRecord buildRecord(int bookingNumber, String summary, double total) {
    return OrderRecord(
      bookingNumber: bookingNumber,
      summary: summary,
      total: total,
      date: '01/01/2026',
    );
  }

  setUp(() async {
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: MovieDatabase.instance.createTables,
      ),
    );
    MovieDatabase.instance.setDatabase(database);
  });

  test('insertOrder stored an order and returns its id', () async {
    final int id = await MovieDatabase.instance.insertOrder(
      buildRecord(1, '1 x Draculla', 10.50),
    );
    expect(id, greaterThan(0));

    final List<OrderRecord> orders =
        await MovieDatabase.instance.getAllOrders();

    expect(orders.length, 1);
    expect(orders[0].id, id);
    expect(orders[0].summary, '1 x Draculla');
    expect(orders[0].total, 10.50);
  });

  test('insertOrder stores movie and showing details for each item', () async {
    final Movie movie = Movie(
      id: 12,
      title: 'The Last Voyage',
      ageRating: '12A',
      description: 'A voyage through dangerous waters.',
      date: '01/01/2026',
      timeStart: '20:00',
      timeEnd: '22:00',
      price: 12.50,
      imagePath: 'assets/images/voyage.jpg',
    );

    await MovieDatabase.instance.insertOrder(
      buildRecord(1, '2 x The Last Voyage', 25.0),
      items: <CartItem>[
        CartItem(
          movie: movie,
          title: movie.title,
          quantity: 2,
          date: '02/01/2026',
          timeStart: '18:00',
          timeEnd: '20:00',
        ),
      ],
    );

    final OrderRecord saved =
        (await MovieDatabase.instance.getAllOrders()).single;
    expect(saved.items, hasLength(1));
    expect(saved.items.single.movieId, 12);
    expect(saved.items.single.title, 'The Last Voyage');
    expect(saved.items.single.ageRating, '12A');
    expect(
        saved.items.single.description, 'A voyage through dangerous waters.');
    expect(saved.items.single.date, '02/01/2026');
    expect(saved.items.single.timeStart, '18:00');
    expect(saved.items.single.timeEnd, '20:00');
    expect(saved.items.single.unitPrice, 12.50);
    expect(saved.items.single.quantity, 2);
  });

  test('getNextBookingNumber incriments the current maximum', () async {
    expect(await MovieDatabase.instance.getNextBookingNumber(), 1);

    await MovieDatabase.instance.insertOrder(
      buildRecord(5, 'Order', 5.0),
    );
    expect(await MovieDatabase.instance.getNextBookingNumber(), 6);
  });

  test('getAllOrders returns newest booking number first', () async {
    await MovieDatabase.instance.insertOrder(buildRecord(1, 'First', 5.0));
    await MovieDatabase.instance.insertOrder(buildRecord(3, 'Third', 3.0));
    await MovieDatabase.instance.insertOrder(buildRecord(2, 'Second', 6.0));

    final List<OrderRecord> orders =
        await MovieDatabase.instance.getAllOrders();
    expect(orders[0].bookingNumber, 3);
    expect(orders[1].bookingNumber, 2);
    expect(orders[2].bookingNumber, 1);
  });

  tearDown(() async {
    await MovieDatabase.instance.close();
  });
}
