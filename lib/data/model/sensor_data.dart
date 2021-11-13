import 'dart:convert';

class SensorData {
  final DateTime timestamp;
  final int id;
  final double temperature;

  SensorData(
      {required this.timestamp, required this.id, required this.temperature});

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'id': id,
      'temperature': temperature,
    };
  }

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
        timestamp: DateTime.parse(map['timestamp']),
        id: map['id'],
        temperature: map['temperature']);
  }

  String toJson() => json.encode(toMap());

  factory SensorData.fromJson(String source) =>
      SensorData.fromMap(json.decode(source));
}
