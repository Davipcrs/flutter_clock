import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/view/pickers/date_picker_view.dart';
import 'package:mobile_clock/view/pickers/time_picker_view.dart';

class AddAlarmView extends StatefulWidget {
  const AddAlarmView({super.key});

  @override
  State<AddAlarmView> createState() => _AddAlarmViewState();
}

class _AddAlarmViewState extends State<AddAlarmView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime dateTimeController = DateTime.now();
  late String timeHour;
  late String timeMinute;
  late String dateDay;
  late String dateMonth;
  late TimeOfDay? timeOfDay = TimeOfDay(
      hour: dateTimeController.hour, minute: dateTimeController.minute);
  bool nameControllerErrorValidator = false;

  late bool isDayless;

  @override
  void initState() {
    super.initState();
    timeCorrection();
    isDayless = false;
  }

  void _dateGetter(context) async {
    DateTime? dateTime = await DatePicker(context);
    if (dateTime != null) {
      dateTimeController = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        timeOfDay!.hour.toInt(),
        timeOfDay!.minute.toInt(),
      );
    }
    setState(() {
      timeCorrection();
    });
  }

  void _timeGetter(context, time) async {
    timeOfDay = await timePicker(context, time);
    if (timeOfDay != null) {
      dateTimeController = DateTime(
        dateTimeController.year,
        dateTimeController.month,
        dateTimeController.day,
        timeOfDay!.hour.toInt(),
        timeOfDay!.minute.toInt(),
      );
    }
    setState(() {
      timeCorrection();
    });
  }

  void timeCorrection() {
    timeHour = dateTimeController.hour.toString();
    if (timeHour.length < 2) {
      timeHour = '0$timeHour';
    }
    timeMinute = dateTimeController.minute.toString();
    if (timeMinute.length < 2) {
      timeMinute = '0$timeMinute';
    }
    dateDay = dateTimeController.day.toString();
    if (dateDay.length < 2) {
      dateDay = '0$dateDay';
    }
    dateMonth = dateTimeController.month.toString();
    if (dateMonth.length < 2) {
      dateMonth = '0$dateMonth';
    }
  }

  _addOnTap() {
    if (nameController.text.isEmpty) {
      setState(
        () {
          nameControllerErrorValidator = true;
        },
      );
      return;
    }
    AlarmModel alarmModel = AlarmModel(
        id: 0,
        isActive: true,
        name: nameController.text,
        desc: descriptionController.text,
        time: dateTimeController,
        dayless: isDayless //dayless alarms
        );
    DB.instance.insertAlarm(alarmModel);

    nameController.clear();
    descriptionController.clear();
    dateTimeController = DateTime.now();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.height) - kToolbarHeight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Enter alarm Name',
                    errorText: nameControllerErrorValidator
                        ? 'Name cant be empty'
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Enter alarm Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('isDayless'),
                    Switch(
                      value: isDayless,
                      onChanged: (value) {
                        setState(
                          () {
                            isDayless = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    splashColor: isDayless
                        ? Colors.transparent
                        : Theme.of(context).splashColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isDayless
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).scaffoldBackgroundColor),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Text(
                          '$dateDay/$dateMonth',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (!isDayless) {
                        _dateGetter(context);
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: Text(
                          '$timeHour:$timeMinute',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1),
                        ),
                      ),
                    ),
                    onTap: () => _timeGetter(
                      context,
                      TimeOfDay.fromDateTime(dateTimeController),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        nameController.clear();
                        descriptionController.clear();
                        dateTimeController = DateTime.now();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ElevatedButton(
                      onPressed: () => _addOnTap(),
                      child: const Text('Add'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
