import 'dart:convert';

class SensorDetailUpdate {
  final String? label;
  final int? sendDelay;
  final int? updateDelay;
  final double? minTemp;
  final double? maxTemp;

  SensorDetailUpdate({
    this.label,
    this.sendDelay,
    this.updateDelay,
    this.minTemp,
    this.maxTemp,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'sendDelay': sendDelay,
      'updateDelay': updateDelay,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
    };
  }

  factory SensorDetailUpdate.fromMap(Map<String, dynamic> map) {
    return SensorDetailUpdate(
      label: map['label'],
      sendDelay: map['sendDelay'],
      updateDelay: map['updateDelay'],
      minTemp: map['minTemp'],
      maxTemp: map['maxTemp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorDetailUpdate.fromJson(String source) =>
      SensorDetailUpdate.fromMap(json.decode(source));
}
