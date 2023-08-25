import 'package:flutter/material.dart';
import 'package:mobile_clock/controller/alarm_controller.dart';
import 'package:mobile_clock/controller/db.dart';
import 'package:mobile_clock/model/alarm_model.dart';
import 'package:mobile_clock/view/bottom_sheet.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late List alarms;

  _activateAlarmsOnInit() async {
    alarms = await DB.instance.retrieveAlarm();
    AlarmController controller = AlarmController();

    for (int i = 0; i < alarms.length; i++) {
      if (alarms[i].isActive) {
        controller.initAlarm(alarms[i]);
      }
    }

    //print(controler.listActiveAlarms());
    //return controler;
  }

  @override
  Widget build(BuildContext context) {
    _activateAlarmsOnInit();
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
                            "Nome: ${snapshot.data[index].name}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, top: 12),
                                child: Switch(
                                  value: snapshot.data[index].isActive,
                                  onChanged: (value) {
                                    snapshot.data[index].isActive = value;
                                    if (snapshot.data[index].isActive == true) {
                                      AlarmController()
                                          .initAlarm(snapshot.data[index]);
                                    } else {
                                      AlarmController().disableAlarm(
                                          snapshot.data[index].id);
                                    }
                                    setState(() {
                                      DB.instance
                                          .updateAlarm(snapshot.data[index]);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            snapshot.data[index].dayless ? "Hora: ${snapshot.data[index].time.toString().split('.')[0].split(':')[3]}:${snapshot.data[index].time.toString().split('.')[0].split(':')[3]}" : //Add Hour in the interface.
                            "Hora: ${snapshot.data[index].time.toString().split('.')[0]}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () => alarmBottomSheet(context, snapshot.data[index]),
                );
              },
            ),
          );
        });
  }
}
