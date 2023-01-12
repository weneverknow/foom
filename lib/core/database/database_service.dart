import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<String> getDbPath() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'foom.db');
    return path;
  }

  static Future<void> initDatabase() async {
    final dbPath = await getDbPath();
    _database = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      print("database `foom` created");
    });
  }

  static Future<Database> initDb() async {
    final dbPath = await getDbPath();
    final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      print("database `foom` created");
    });
    return db;
  }
}
