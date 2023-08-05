import 'package:mobile_clock/model/alarm.dart';
import 'package:mobile_clock/model/db.dart';

retrieveAlarm(Alarm alarm) async {
  //https://docs.flutter.dev/cookbook/persistence/sqlite

  final DB db = DB.instance;
  var client = await db.database;

  var result = await client.query("alarm");

  List<Alarm> list =
      result.isNotEmpty ? result.map((c) => Alarm.fromMap(c)).toList() : [];

  return list;
}
