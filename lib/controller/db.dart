import 'package:mobile_clock/model/alarm_model.dart';
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
      isActive INTEGER,
      dayless INTEGER
      );
      ''';
    await db.execute(alarm);
  }

  insertAlarm(AlarmModel alarm) async {
    //https://docs.flutter.dev/cookbook/persistence/sqlite

    Database db = await instance.database;

    await db.insert('alarm', alarm.toMapDatabase());
  }

  retrieveAlarm() async {
    //https://docs.flutter.dev/cookbook/persistence/sqlite

    Database db = await instance.database;
    var result = await db.query("alarm");

    List<AlarmModel> list = result.isNotEmpty
        ? result.map((c) => AlarmModel.fromMapDatabase(c)).toList()
        : [];

    return list;
  }

  updateAlarm(AlarmModel alarmModel) async {
    Database db = await instance.database;

    await db.update(
      'alarm',
      alarmModel.toMapDatabase(),
      where: 'id = ?',
      whereArgs: [alarmModel.id],
    );

    return;
  }

  deleteAlarm(int id) async {
    Database db = await instance.database;

    await db.delete(
      'alarm',
      where: 'id = ?',
      whereArgs: [id],
    );
    return;
  }

  retrieveSpecificAlarm(int id) async {
    Database db = await instance.database;

    var result = await db.query(
      'alarm',
      where: 'id = ?',
      whereArgs: [id],
    );
    AlarmModel alarmModel = AlarmModel.fromMapDatabase(result[0]);
    return alarmModel;
  }

  //var databasepath = await getDatabasesPath();
}
