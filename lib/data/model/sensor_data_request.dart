class SensorDataRequest {
  final DateTime? from;
  final DateTime? to;

  SensorDataRequest({this.from, this.to});

  @override
  String toString() {
    String str = '';

    if (from != null) {
      str = 'from=${from!.toIso8601String()}&';
    }

    if (to != null) {
      str = '${str}to=${to!.toIso8601String()}';
    }

    return str;
  }
}
