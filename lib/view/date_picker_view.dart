import 'package:flutter/material.dart';

Future<DateTime?> DatePicker(context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}
