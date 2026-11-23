import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking_record.dart';

void main() {
  const OrderRecord order = OrderRecord(
    bookingNumber: 4,
    summary: '3 x Godzila',
    total: 20.50,
    date: '01/01/2026 09:05',
  );

  test('New orders omit database ids and convert to map', () {
    expect(order.id, isNull);
    expect(order.toMap(), <String, Object?>{
      'booking_number': 4,
      'summary': '3 x Godzila',
      'total': 20.50,
      'date': '01/01/2026 09:05',
    });
  });

  test('A database map converts back into an order', () {
    final Map<String, Object?> row = <String, Object?>{
      'id': 7,
      'booking_number': 10,
      'summary': '1 x Godzila',
      'total': 6.0,
      'date': '02/01/2026'
    };
    final OrderRecord restored = OrderRecord.fromMap(row);
    expect(restored.id, 7);
    expect(restored.bookingNumber, 10);
    expect(restored.summary, '1 x Godzila');
    expect(restored.total, 6.0);
    expect(restored.date, '02/01/2026');
    expect(restored.toMap(), row);
  });

  test('Whole-number SQLite totals become doubles', () {
    final Map<String, Object?> row = order.toMap();
    row['total'] = 6;
    final OrderRecord restored = OrderRecord.fromMap(row);
    expect(restored.total, 6.0);
    expect(restored.total, isA<double>());
  });

  test('Order item maps preserve movie and showing details', () {
    const OrderItem item = OrderItem(
      movieId: 7,
      title: 'Test Movie',
      ageRating: 'PG',
      description: 'A test movie.',
      date: '19/04/2024',
      timeStart: '18:00',
      timeEnd: '20:00',
      unitPrice: 10.50,
      quantity: 2,
    );

    final Map<String, Object?> row = item.toMap(orderId: 4);
    final OrderItem restored = OrderItem.fromMap(row);

    expect(row, <String, Object?>{
      'order_id': 4,
      'movie_id': 7,
      'title': 'Test Movie',
      'age_rating': 'PG',
      'description': 'A test movie.',
      'show_date': '19/04/2024',
      'time_start': '18:00',
      'time_end': '20:00',
      'unit_price': 10.50,
      'quantity': 2,
    });
    expect(restored.movieId, item.movieId);
    expect(restored.title, item.title);
    expect(restored.ageRating, item.ageRating);
    expect(restored.description, item.description);
    expect(restored.date, item.date);
    expect(restored.timeStart, item.timeStart);
    expect(restored.timeEnd, item.timeEnd);
    expect(restored.unitPrice, item.unitPrice);
    expect(restored.quantity, item.quantity);
  });

  test('Whole-number SQLite item prices become doubles', () {
    final Map<String, Object?> row = const OrderItem(
      movieId: 1,
      title: 'Test Movie',
      ageRating: 'PG',
      description: 'A test movie.',
      date: '19/04/2024',
      timeStart: '18:00',
      timeEnd: '20:00',
      unitPrice: 10.0,
      quantity: 1,
    ).toMap(orderId: 1);
    row['unit_price'] = 10;

    final OrderItem restored = OrderItem.fromMap(row);
    expect(restored.unitPrice, 10.0);
    expect(restored.unitPrice, isA<double>());
  });
}
