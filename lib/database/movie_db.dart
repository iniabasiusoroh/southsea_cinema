import 'package:path/path.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  MovieDatabase._internal();
  static final MovieDatabase instance = MovieDatabase._internal();
  static Database? _database;

  void setDatabase(Database? db) {
    _database = db;
  }
}