import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sensor extends Equatable {
  final DateTime createdAt;
  final int id;
  final String label;
  final String uuid;

  const Sensor(
      {required this.createdAt,
      required this.label,
      required this.id,
      required this.uuid});

  @override
  List<Object?> get props => [createdAt, id, label, uuid];

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
      'label': label,
      'uuid': uuid,
    };
  }

  factory Sensor.fromMap(Map<String, dynamic> map) {
    return Sensor(
      createdAt: DateTime.parse(map['createdAt']),
      id: map['id'],
      label: map['label'],
      uuid: map['uuid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sensor.fromJson(String source) => Sensor.fromMap(json.decode(source));
}
