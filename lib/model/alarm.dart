class Alarm {
  Alarm({
    required this.time,
    required this.name,
    required this.isActive,
    this.desc,
    this.priority,
  });
  DateTime time;
  String name;
  bool isActive;
  late String? desc;
  late int? priority;
}
