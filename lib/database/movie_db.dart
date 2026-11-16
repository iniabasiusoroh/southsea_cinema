import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:southsea_cinema/models/booking_record.dart';

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
      version: 1,
      onCreate: _createDB,
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

  Future<int> insertOrder(OrderRecord order) async {
      final Database db = await database;
      final int id = await db.insert('orders', order.toMap());
      return id;
    }

    Future<List<OrderRecord>> getAllOrders() async {
      final Database db = await database;
      final List<Map<String, Object?>> records =
          await db.query('orders', orderBy: 'booking_number DESC');

      final List<OrderRecord> orders = [];
      for (final Map<String, Object?> row in records) {
        orders.add(OrderRecord.fromMap(row));
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
