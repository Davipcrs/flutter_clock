import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/view/time_picker_view.dart';

class AddAlarmView extends StatefulWidget {
  const AddAlarmView({super.key});

  @override
  State<AddAlarmView> createState() => _AddAlarmViewState();
}

class _AddAlarmViewState extends State<AddAlarmView> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();
  DateTime time_controller = DateTime.now();
  late String timeHour;
  late String timeMinute;
  late String dateDay;
  late String dateMonth;
  late TimeOfDay? timeOfDay;
  bool name_error_validator = false;

  @override
  void initState() {
    super.initState();
    timeCorrection();
  }

  void _timeGetter(context, time) async {
    timeOfDay = await timePicker(context, time);
    if (timeOfDay != null) {
      time_controller = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        timeOfDay!.hour.toInt(),
        timeOfDay!.minute.toInt(),
      );
    }
    setState(() {
      timeCorrection();
    });
  }

  void timeCorrection() {
    timeHour = time_controller.hour.toString();
    if (timeHour.length < 2) {
      timeHour = '0$timeHour';
    }
    timeMinute = time_controller.minute.toString();
    if (timeMinute.length < 2) {
      timeMinute = '0$timeMinute';
    }
    dateDay = time_controller.day.toString();
    if (dateDay.length < 2) {
      dateDay = '0$dateDay';
    }
    dateMonth = time_controller.month.toString();
    if (dateMonth.length < 2) {
      dateMonth = '0$dateMonth';
    }
  }

  _addOnTap() {
    if (name_controller.text.isEmpty) {
      setState(
        () {
          name_error_validator = true;
        },
      );
      return;
    }
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
                errorText: name_error_validator ? 'Name cant be empty' : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: desc_controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter alarm Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Text(
                      '$dateDay/$dateMonth',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1),
                    ),
                  ),
                ),
                onTap: () => null,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Text(
                      '$timeHour:$timeMinute',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1),
                    ),
                  ),
                ),
                onTap: () => _timeGetter(
                  context,
                  TimeOfDay.fromDateTime(time_controller),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => null,
                child: Text('Cancel'),
              ),
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
