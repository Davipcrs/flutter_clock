import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/model/db.dart';

Future<List> retrieveAlarm() async {
  //https://docs.flutter.dev/cookbook/persistence/sqlite

  final DB db = DB.instance;
  var client = await db.database;

  var result = await client.query("alarm");

  List<AlarmModel> list = result.isNotEmpty
      ? result.map((c) => AlarmModel.fromMap(c)).toList()
      : [];

  print(list[0]);
  return list;
}
