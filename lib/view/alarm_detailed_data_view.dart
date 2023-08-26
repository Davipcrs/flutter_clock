import 'package:flutter/material.dart';
import 'package:mobile_clock/model/alarm_model.dart';

class AlarmDetailedView extends StatelessWidget {
  const AlarmDetailedView({super.key, required this.model});

  final AlarmModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: ${model.name}'),
            Text('Description: ${model.desc}'),
            Text('is Day-less: ${model.dayless}'),
            Text('Time: ${model.time}'),
            Text('is Active: ${model.isActive}'),
            Text('id: ${model.id}'),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Return'))
          ],
        ),
      ),
    );
  }
}
