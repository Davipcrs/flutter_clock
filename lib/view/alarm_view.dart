import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/insert_data_db.dart';
import 'package:mobile_clock/controller/retrive_data.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  bool test = false;
  late List alarms;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    insert();
  }

  retrieve() async {
    alarms = await retrieveAlarm();
  }

  insert() async {
    await insertAlarm(
      AlarmModel(
          time: DateTime.now(),
          name: 'name',
          isActive: true,
          id: 0,
          desc: 'desc',
          priority: 0),
    ).then((value) => retrieve());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.7,
      child: ListView.builder(
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemCount: alarms.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "hora",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16, top: 12),
                          child: Switch(
                            value: test,
                            onChanged: (value) => print("changed"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Desc",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () => print("tapped"),
          );
        },
      ),
    );
  }
}
