import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/view/pickers/date_picker_view.dart';
import 'package:mobile_clock/view/pickers/time_picker_view.dart';

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

    nameController = TextEditingController(text: alarmModel.name);
    descriptionController = TextEditingController(text: alarmModel.desc);
    dateTimeController = alarmModel.time;

    timeCorrection();
  }

  late AlarmModel alarmModel;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late DateTime dateTimeController;
  late String timeHour;
  late String timeMinute;
  late String dateDay;
  late String dateMonth;
  late TimeOfDay? timeOfDay = TimeOfDay(
      hour: dateTimeController.hour, minute: dateTimeController.minute);
  bool nameControllerErrorValidator = false;

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
    alarmModel.desc = descriptionController.text;
    alarmModel.name = nameController.text;
    alarmModel.time = dateTimeController;

    DB.instance.updateAlarm(alarmModel);

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
                    controller: descriptionController,
                    maxLines: null,
                    expands: true,
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1),
                        ),
                      ),
                    ),
                    onTap: () => _dateGetter(context),
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
