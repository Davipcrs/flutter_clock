import 'package:flutter/material.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  bool test = false;
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
                  children: [
                    Text("Nome do alarme"),
                    Text("Start"),
                    Text("Hora"),
                  ],
                ),
                Row(
                  children: [
                    Text("Desc"),
                    Text("end"),
                    Text("Hora"),
                  ],
                ),
                Column(
                  children: [
                    Switch(
                      value: test,
                      onChanged: (value) => print("changed"),
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
