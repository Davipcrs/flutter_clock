import 'package:flutter/material.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  bool test = false;
  late List alarms;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.7,
      child: ListView.builder(
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemCount: 30,
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
