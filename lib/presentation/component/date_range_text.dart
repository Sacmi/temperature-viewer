import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeText extends StatelessWidget {
  DateRangeText({Key? key, this.from, this.end}) : super(key: key) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    String output = '';

    if (end != null) {
      output = 'по ${dateFormat.format(end!)}';
    } else {
      output = 'по настоящее время';
    }

    if (from != null) {
      _output = 'C ${dateFormat.format(from!)} $output';
    } else {
      _output = _capitalize(output);
    }
  }

  static String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  final DateTime? from;
  final DateTime? end;

  late final String _output;

  @override
  Widget build(BuildContext context) {
    return Text(_output);
  }
}
