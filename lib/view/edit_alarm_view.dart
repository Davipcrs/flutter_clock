import 'package:flutter/material.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class EditAlarmView extends StatefulWidget {

  const EditAlarmView({super.key, this.args});
  final args;
  @override
  State<EditAlarmView> createState() => _EditAlarmViewState();
}

class _EditAlarmViewState extends State<EditAlarmView> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alarmModel = widget.args as AlarmModel;
  }
  late AlarmModel alarmModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('${alarmModel.name}'),
      ],
    );
  }
}