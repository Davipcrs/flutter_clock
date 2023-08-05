class Alarm {
  Alarm({
    required this.time,
    required this.name,
    required this.isActive,
    this.desc,
    this.priority,
    this.id,
  });
  DateTime time;
  String name;
  bool isActive;
  late String? desc;
  late int? priority;
  late int? id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'isActive': isActive,
      'desc': desc,
      'priority': priority,
    };
  }

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
        id: json['id'],
        time: json['time'],
        name: json['name'],
        isActive: json['isActive'],
        desc: json['desc'],
        priority: json['priority'],
      );
}
