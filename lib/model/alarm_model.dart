class AlarmModel {
  AlarmModel({
    required this.time,
    required this.name,
    required this.isActive,
    this.desc,
    this.priority,
    required this.id,
  });
  DateTime time;
  String name;
  bool isActive;
  late String? desc;
  late int? priority;
  late int id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time.toString(),
      'isActive': isActive ? 1 : 0,
      'desc': desc,
      'priority': priority,
    };
  }

  Map<String, dynamic> toMapDatabase() {
    return {
      'time': time.toString(),
      'name': name,
      'desc': desc,
      'priority': priority,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory AlarmModel.fromMapDatabase(Map<String, dynamic> json) => AlarmModel(
        id: json['id'],
        time: DateTime.parse(json['time']),
        name: json['name'],
        isActive: json['isActive'] == 0 ? false : true,
        desc: json['desc'],
        priority: json['priority'],
      );

  factory AlarmModel.fromAlarmSettings(Map<String, dynamic> settings) =>
      AlarmModel(
        time: settings['dateTime'],
        name: settings['notificationTitle'],
        isActive: true,
        id: settings['id'],
        desc: settings['notificationBody'],
      );
}
