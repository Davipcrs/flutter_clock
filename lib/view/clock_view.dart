import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime time;
  late String timeHour;
  late String timeMin;
  double fontsize = 20;
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
    print(fontsize);
  }

  @override
  void initState() {
    // TODO: implement initState
    time = DateTime.now();
    timeCorrection();
    super.initState();
  }

  void refreshTime(context) {
    setState(
      () {
        time = DateTime.now();
        timeCorrection();
        fontCorrection(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fontsize == 0) {
      fontCorrection(context);
    }
    Timer(Duration(milliseconds: 3000), () {
      refreshTime(context);
    });
    return Scaffold(
      body: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height - kToolbarHeight),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  "$timeHour:$timeMin",
                  style: TextStyle(
                    fontSize: fontsize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
