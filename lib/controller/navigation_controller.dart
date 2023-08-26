import 'package:flutter/material.dart';
import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/view/add_alarm_view.dart';
import 'package:mobile_clock/view/alarm_detailed_data_view.dart';
import 'package:mobile_clock/view/clock_view.dart';
import 'package:mobile_clock/view/edit_alarm_view.dart';

class RouteGen {
  static Route<dynamic> genRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/addAlarm':
        return MaterialPageRoute(builder: (_) => const AddAlarmView());

      case '/editAlarm':
        return MaterialPageRoute(builder: (_) => EditAlarmView(args: args));

      case '/alarmDetailedView':
        return MaterialPageRoute(
            builder: (_) => AlarmDetailedView(model: args as AlarmModel));

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
