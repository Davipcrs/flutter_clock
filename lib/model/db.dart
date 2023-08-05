import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'alarm.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    const String alarm = '''
      CREATE TABLE alarm(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      time TEXT, 
      name TEXT, 
      desc TEXT, 
      priority INTEGER, 
      isActive INTEGER
      );

  ''';

    await db.execute(alarm);
  }

  //var databasepath = await getDatabasesPath();
}
