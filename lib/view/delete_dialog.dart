import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/controller/string_controller.dart';
import 'package:mobile_clock/model/alarm_model.dart';

deleteAlarmDialog(context, AlarmModel alarmModel) {
  AppStrings str = AppStrings();
  return AlertDialog(
    title: Text('Delete Alarm: ${alarmModel.name}'),
    content: const Text('Destructive Action, after the delete\n'
        'The alarm will not be acessible\n'),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(str.cancel),
      ),
      TextButton(
        onPressed: () {
          DB.instance.deleteAlarm(alarmModel.id);
          Navigator.of(context).pop();
        },
        child: const Text('Delete'),
      )
    ],
  );
}
