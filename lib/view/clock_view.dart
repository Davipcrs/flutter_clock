import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_clock/view/alarm_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime time;
  late String timeHour;
  late String timeMin;
  double fontsize = 20;
  var alarmView = const AlarmView();
  //Font Size is multiplied by a constant to be made responsible

  void timeCorrection() {
    timeHour = time.hour.toString();
    if (timeHour.length < 2) {
      timeHour = '0$timeHour';
    }
    timeMin = time.minute.toString();
    if (timeMin.length < 2) {
      timeMin = '0$timeMin';
    }
  }

  void fontCorrection(context) {
    fontsize = MediaQuery.of(context).size.width * 0.32;
  }

  @override
  void initState() {
    time = DateTime.now();
    timeCorrection();
    super.initState();
  }

  void refreshTime(context) {
    setState(
      () {
        time = DateTime.now();
        timeCorrection();
        //fontCorrection(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fontCorrection(context);
    Timer(
      const Duration(milliseconds: 10000),
      () {
        if (DateTime.now().isAfter(time)) {
          refreshTime(context);
        }
      },
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height - kToolbarHeight) * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.of(context).pushNamed('/addAlarm').then((value) => setState(() {
                        alarmView = const AlarmView();
                      }));
                      
                    },
                    
                    child: Text(
                      "$timeHour:$timeMin",
                      style: TextStyle(
                        fontSize: fontsize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          alarmView,

          /*
          SizedBox(
            height: (MediaQuery.of(context).size.height) * 0.7,
            width: (MediaQuery.of(context).size.width) * 0.7,
            child: const AddAlarmView(),
          ),
          */
        ],
      ),
    );
  }
}
