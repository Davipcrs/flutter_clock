import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/alarm_model.dart';

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
    var path = join(await getDatabasesPath(), 'alarm.db');

    return await openDatabase(
      path,
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

  insertAlarm(AlarmModel alarm) async {
    //https://docs.flutter.dev/cookbook/persistence/sqlite

    Database db = await instance.database;

    await db.insert('alarm', alarm.toMap());
  }

  retrieveAlarm() async {
    //https://docs.flutter.dev/cookbook/persistence/sqlite

    Database db = await instance.database;
    var result = await db.query("alarm");

    List<AlarmModel> list = result.isNotEmpty
        ? result.map((c) => AlarmModel.fromMap(c)).toList()
        : [];

    return list;
  }

  //var databasepath = await getDatabasesPath();
}
