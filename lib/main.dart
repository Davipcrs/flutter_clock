import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:mobile_clock/view/clock_view.dart';

void main() async {
  runApp(const MyApp());
  await Alarm.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

//TODO:
// Criar o local de armazenamento 
// Funcionalidade de ativação e desativação
// Funcionalidade de CRUD
// Funcionalidade de toque (Fazer funcionar)
// Recurrent alarms
