import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/views/orders_view.dart';
import 'package:southsea_cinema/views/basket_view.dart';

import '../cart_repository_test.dart';

void main() {
  setUp(() async {
    CartRepository.instance.clear();
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

  tearDownAll(() async {
    await MovieDatabase.instance.close();
  });

  testWidgets('Checkout saves the order, clears the basket and opens orders', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.addItem(
      const CartItem(
          movie: testMovie1,
          quantity: 2,
          date: '01/01/2026',
          timeEnd: '22:00',
          timeStart: '20:00',
          title: 'Godzila'),
    );

    await tester.pumpWidget(MaterialApp(home: const BasketView(), routes: {
      '/orders': (BuildContext context) {
        return const OrdersView();
      }
    }));
    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    final List<OrderRecord>? orders = await tester.runAsync(() async {
      return await MovieDatabase.instance.getAllOrders();
    });

    expect(orders, isNotNull);
    if (orders != null) {
      expect(orders.length, 1);
      expect(orders[0].bookingNumber, 1);
      expect(orders[0].summary, '2 x The Last Voyage');
      expect(orders[0].total, 25.0);
    }
    expect(CartRepository.instance.getItems(), isEmpty);
    expect(find.byType(OrdersView), findsOneWidget);
  });

  testWidgets('Checkout keeps the basket when saving fails', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.addItem(
      const CartItem(
          movie: testMovie1,
          quantity: 2,
          date: '01/01/2026',
          timeEnd: '22:00',
          timeStart: '20:00',
          title: 'Godzila'),
    );
    await tester.runAsync(() async {
      final Database database = await MovieDatabase.instance.database;
      await database.execute('DROP TABLE orders');
    });

    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    expect(CartRepository.instance.getItems().length, 1);
    expect(find.text("2 x The Last Voyage"), findsOneWidget);
    expect(find.textContaining('Could not save your order'), findsOneWidget);
  });
}
