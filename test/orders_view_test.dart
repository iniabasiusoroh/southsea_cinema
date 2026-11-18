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
        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_number INTEGER NOT NULL,
            summary TEXT NOT NULL,
            total REAL NOT NULL,
            date TEXT NOT NULL
          )
        ''');
        await db.insert('orders', <String, Object?>{
          'booking_number': 1,
          'summary': 'Test booking',
          'total': 10.0,
          'date': '18/04/2024 12:32',
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
    expect(find.byType(CircularProgressIndicator), findsNothing);
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
}
