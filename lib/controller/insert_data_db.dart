import 'package:mobile_clock/model/alarm.dart';
import 'package:mobile_clock/model/db.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertAlarm(Alarm alarm) async {
  //https://docs.flutter.dev/cookbook/persistence/sqlite

  final DB db = DB.instance;
  var client = await db.database;

  await client.insert('alarm', alarm.toMap(), ConflictAlgorithm.replace);
}
