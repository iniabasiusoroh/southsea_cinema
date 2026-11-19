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
}
