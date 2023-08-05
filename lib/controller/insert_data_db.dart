import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/model/db.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertAlarm(AlarmModel alarm) async {
  //https://docs.flutter.dev/cookbook/persistence/sqlite

  Database db = await DB.instance.database;

  await db.insert('alarm', alarm.toMap());
  print(alarm.name);
}
