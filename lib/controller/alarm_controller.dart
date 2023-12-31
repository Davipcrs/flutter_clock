import 'package:alarm/alarm.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class AlarmController {
  AlarmController();

  //Make Alarms note Date Dependent.
  _modifyAlarmDate(AlarmModel alarmModel) {
    if (alarmModel.dayless) {
      DateTime aux = alarmModel.time;
      alarmModel.time = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        aux.hour,
        aux.minute,
        aux.second,
      );
      return alarmModel;
    }
    return alarmModel;
  }

  initAlarm(AlarmModel alarmModel) async {
    alarmModel = _modifyAlarmDate(alarmModel);
    AlarmSettings settings = AlarmSettings(
      id: alarmModel.id,
      dateTime: alarmModel.time,
      assetAudioPath: 'assets/audio.mp3',
      vibrate: true,
      notificationTitle: alarmModel.name,
      notificationBody: alarmModel.desc,
      volumeMax: true,
    );
    await Alarm.set(alarmSettings: settings);
  }

  listActiveAlarms() async {
    var list = Alarm.getAlarms();
    var i = 0;
    var alarmModelList = [];
    while (list.length < i) {
      var model = AlarmModel.fromAlarmSettings(list[i].toJson());
      alarmModelList.add(model);
      i = i + 1;
    }
    return alarmModelList;
  }

  isAlarmInative(int id) {
    if (Alarm.getAlarm(id) == null) {
      return true;
    }
    return false;
  }

  disableAlarm(int id) async {
    await Alarm.stop(id);
  }
}
