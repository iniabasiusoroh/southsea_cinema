import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/models/cart_item.dart';

class MovieDatabase {
  MovieDatabase._internal();

  static final MovieDatabase instance = MovieDatabase._internal();

  static Database? _database;

  void setDatabase(Database? db) {
    _database = db;
  }

  Future<Database> get database async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      return cachedDatabase;
    }
    final Database db = await _initDB('movie_database.db');
    _database = db;
    return db;
  }

  Future<Database> _initDB(String fileName) async {
    final String folder = await getDatabasesPath();
    final String filePath = join(folder, fileName);
    final Database db = await openDatabase(
      filePath,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
    return db;
  }

  Future<void> createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_number INTEGER NOT NULL,
        summary TEXT NOT NULL,
        total REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
    await _createOrderItemsTable(db);
  }

  Future<void> _createOrderItemsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        movie_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        age_rating TEXT NOT NULL,
        description TEXT NOT NULL,
        show_date TEXT NOT NULL,
        time_start TEXT NOT NULL,
        time_end TEXT NOT NULL,
        unit_price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (id)
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createOrderItemsTable(db);
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await createTables(db, version);
    await db.insert(
      'orders',
      <String, Object?>{
        'booking_number': 1,
        'summary': 'Inserted for testing.',
        'total': 10.00,
        'date': "18/04/2024 12:32",
      },
    );
    await db.insert(
      'orders',
      <String, Object?>{
        'booking_number': 2,
        'summary': 'Inserted for testing.',
        'total': 20.00,
        'date': "18/04/2024 12:45",
      },
    );
    await db.insert(
      'orders',
      <String, Object?>{
        'booking_number': 3,
        'summary': 'Inserted for testing.',
        'total': 30.00,
        'date': "18/04/2024 12:50",
      },
    );
  }

  Future<int> insertOrder(
    OrderRecord order, {
    List<CartItem> items = const <CartItem>[],
  }) async {
    final Database db = await database;
    final int id = await db.transaction((Transaction transaction) async {
      final int orderId = await transaction.insert('orders', order.toMap());
      for (final CartItem item in items) {
        await transaction.insert(
          'order_items',
          OrderItem(
            movieId: item.movie.id,
            title: item.movie.title,
            ageRating: item.movie.ageRating,
            description: item.movie.description,
            date: item.date,
            timeStart: item.timeStart,
            timeEnd: item.timeEnd,
            unitPrice: item.movie.price.toDouble(),
            quantity: item.quantity,
          ).toMap(orderId: orderId),
        );
      }
      return orderId;
    });
    return id;
  }

  Future<List<OrderRecord>> getAllOrders() async {
    final Database db = await database;
    final List<Map<String, Object?>> records =
        await db.query('orders', orderBy: 'booking_number DESC');
    final List<Map<String, Object?>> itemRecords =
        await db.query('order_items', orderBy: 'id');
    final Map<int, List<OrderItem>> itemsByOrder = <int, List<OrderItem>>{};
    for (final Map<String, Object?> row in itemRecords) {
      final int orderId = row['order_id'] as int;
      itemsByOrder
          .putIfAbsent(orderId, () => <OrderItem>[])
          .add(OrderItem.fromMap(row));
    }

    final List<OrderRecord> orders = [];
    for (final Map<String, Object?> row in records) {
      final OrderRecord order = OrderRecord.fromMap(row);
      final int? orderId = order.id;
      orders.add(OrderRecord(
        id: order.id,
        bookingNumber: order.bookingNumber,
        summary: order.summary,
        total: order.total,
        date: order.date,
        items: orderId == null
            ? const <OrderItem>[]
            : itemsByOrder[orderId] ?? const <OrderItem>[],
      ));
    }
    return orders;
  }

  Future<int> getNextBookingNumber() async {
    final Database db = await database;
    final List<Map<String, Object?>> records = await db.rawQuery(
      'SELECT MAX(booking_number) as max_booking_number FROM orders',
    );

    if (records.isEmpty) {
      return 1;
    }
    final Object? maxValue = records[0]['max_booking_number'];
    if (maxValue == null) {
      return 1;
    }
    final int currentMax = maxValue as int;
    return currentMax + 1;
  }

  Future<void> close() async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      await cachedDatabase.close();
      _database = null;
    }
  }
}

// Seed past orders only when creating the database.
