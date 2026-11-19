import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
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

    final List<OrderRecord> orders = await MovieDatabase.instance.getAllOrders();

    expect (orders.length, 1);
    expect (orders[0].id, id);
    expect (orders[0].summary, '1 x Draculla');
    expect (orders[0].total, 10.50);
  });

  test ('getNextBookingNumber incriments the current maximum', () async {
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

    final List<OrderRecord> orders = await MovieDatabase.instance.getAllOrders();
    expect(orders[0].bookingNumber, 3);
    expect(orders[1].bookingNumber, 2);
    expect(orders[2].bookingNumber, 1);
    
  });
  
  tearDown(() async {
    await MovieDatabase.instance.close();
  });
}

