import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  bool test = false;
  late List alarms;

  _retrieveAlarms() async {
    alarms = await DB.instance.retrieveAlarm();
  }

  @override
  Widget build(BuildContext context) {
    _retrieveAlarms();
    return FutureBuilder<dynamic>(
        future: DB.instance.retrieveAlarm(),
        builder: (context, snapshot) {
          return SizedBox(
            height: (MediaQuery.of(context).size.height) * 0.7,
            child: ListView.builder(
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "hora: ${snapshot.data[index].name}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, top: 12),
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
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
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
        });
  }
}
