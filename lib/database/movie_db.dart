import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final Database db = await _initDB ('movie_database.db');
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

  Future<void> _createDB (Database db, int version) async {
    await createTables(db, version);
    await db.insert('orders', <String, Object?>{
        'booking_number': 1,
        'summary': 'Inserted for testing.',
        'total': 10.00,
        'date': "18/04/2024 12:32",
      },
    );
    await db.insert('orders', <String, Object?>{
        'booking_number': 2,
        'summary': 'Inserted for testing.',
        'total': 20.00,
        'date': "18/04/2024 12:45",
      },
    );
  }
}

// Seed past orders only when creating the database.