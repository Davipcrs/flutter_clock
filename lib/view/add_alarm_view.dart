import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class AddAlarmView extends StatefulWidget {
  const AddAlarmView({super.key});

  @override
  State<AddAlarmView> createState() => _AddAlarmViewState();
}

class _AddAlarmViewState extends State<AddAlarmView> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();
  DateTime time_controller = DateTime.now();

  _addOnTap() {
    AlarmModel alarmModel = AlarmModel(
      id: 0,
      isActive: true,
      name: name_controller.text,
      desc: desc_controller.text,
      time: time_controller,
    );
    DB.instance.insertAlarm(alarmModel);

    name_controller.clear();
    desc_controller.clear();
    time_controller = DateTime.now();

    print(DB.instance.retrieveAlarm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: name_controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter alarm Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          TextField(
            controller: desc_controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Enter alarm Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Row(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => _addOnTap(),
                child: Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
