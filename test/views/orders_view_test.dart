import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/views/orders_view.dart';


void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await MovieDatabase.instance.createTables(db, version);
        final int orderId = await db.insert('orders', <String, Object?>{
          'booking_number': 1,
          'summary': 'Test booking',
          'total': 10.0,
          'date': '18/04/2024 12:32',
        });
        await db.insert('order_items', <String, Object?>{
          'order_id': orderId,
          'movie_id': 7,
          'title': 'Test Movie',
          'age_rating': 'PG',
          'description': 'A test movie description.',
          'show_date': '19/04/2024',
          'time_start': '18:00',
          'time_end': '20:00',
          'unit_price': 10.0,
          'quantity': 1,
        });
      },
    );
    MovieDatabase.instance.setDatabase(database);
  });

  tearDownAll(() async {
    await MovieDatabase.instance.close();
  });

  testWidgets('shows orders after the database query completes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OrdersView()));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    expect(find.text('Booking #1'), findsOneWidget);
    expect(find.text('1 x Test Movie'), findsOneWidget);
    expect(find.text('PG · 19/04/2024 · 18:00-20:00'), findsOneWidget);
    expect(find.text('A test movie description.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    final ThemeData theme = Theme.of(tester.element(find.byType(OrdersView)));
    final Card card = tester.widget<Card>(find.byType(Card).first);
    final Text title = tester.widget<Text>(find.text('1 x Test Movie'));
    expect(card.color, theme.colorScheme.surface);
    expect(title.style?.color, theme.colorScheme.onSurface);
  });

  testWidgets('order card uses readable colors in dark mode',
      (WidgetTester tester) async {
    final ThemeData theme = ThemeData.dark();
    await tester.pumpWidget(
      MaterialApp(theme: theme, home: const OrdersView()),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    final Card card = tester.widget<Card>(find.byType(Card).first);
    final Text title = tester.widget<Text>(find.text('1 x Test Movie'));
    expect(card.color, theme.colorScheme.surface);
    expect(title.style?.color, theme.colorScheme.onSurface);
  });

  testWidgets('shows error message when database query fails',
      (WidgetTester tester) async {
    await MovieDatabase.instance.close();
    await tester.pumpWidget(const MaterialApp(home: OrdersView()));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    expect(find.textContaining('Error loading orders'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  // testWidgets('OrdersView lists saved orders newest-first', (
  //   WidgetTester tester,
  // ) async {
  //   await tester.runAsync(() async {
  //     await MovieDatabase.instance.insertOrder(
  //       const OrderRecord(
  //           bookingNumber: 1,
  //           summary: 'Test booking',
  //           total: 10.0,
  //           date: '18/04/2024 12:32'),
  //     );
  //     await MovieDatabase.instance.insertOrder(
  //       const OrderRecord(
  //           bookingNumber: 2,
  //           summary: 'Test booking 2',
  //           total: 15.00,
  //           date: '02/01/2026 11:00'),
  //     );

  //     await tester.pumpWidget(const MaterialApp(home: OrdersView()));
  //     await tester.pumpAndSettle();
  //   });

  //   await tester.pump();

  //   expect(find.text('Order #1'), findsOneWidget);
  //   expect(find.text('Order #2'), findsOneWidget);
  //   expect(find.text('Test booking 2'), findsOneWidget);
  //   final double newestY = tester.getTopLeft(find.text('Order #1')).dy;
  //   final double oldestY = tester.getTopLeft(find.text('Order #2')).dy;
  //   expect(newestY, lessThan(oldestY));
  // });
}
