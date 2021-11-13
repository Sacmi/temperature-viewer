import 'dart:convert';

class SensorDetail {
  final DateTime createdAt;
  final int id;
  final String label;
  final String uuid;
  final double maxTemp;
  final double minTemp;
  final int sendDelay;
  final int updateDelay;

  SensorDetail({
    required this.createdAt,
    required this.id,
    required this.label,
    required this.uuid,
    required this.maxTemp,
    required this.minTemp,
    required this.sendDelay,
    required this.updateDelay,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
      'label': label,
      'uuid': uuid,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'sendDelay': sendDelay,
      'updateDelay': updateDelay,
    };
  }

  factory SensorDetail.fromMap(Map<String, dynamic> map) {
    return SensorDetail(
      createdAt: DateTime.parse(map['createdAt']),
      id: map['id'],
      label: map['label'],
      uuid: map['uuid'],
      maxTemp: map['maxTemp'],
      minTemp: map['minTemp'],
      sendDelay: map['sendDelay'],
      updateDelay: map['updateDelay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorDetail.fromJson(String source) =>
      SensorDetail.fromMap(json.decode(source));
}
