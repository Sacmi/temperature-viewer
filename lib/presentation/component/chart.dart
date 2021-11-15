import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:temperature_viewer/data/model/sensor_data.dart';

class TimeSeriesTemperature {
  final DateTime time;
  final double temperature;

  TimeSeriesTemperature(this.time, this.temperature);
}

class TemperatureChart extends StatelessWidget {
  final List<SensorData> sensorData;

  const TemperatureChart({Key? key, required this.sensorData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.5;

    if (sensorData.isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Text('Недостаточно данных для построения графика'),
        ),
      );
    }

    final dateFormat = DateFormat('dd.MM.yy hh:MM:SS');

    return SizedBox(
      width: width,
      height: height,
      child: Chart<SensorData>(
        data: sensorData,
        variables: {
          'Дата': Variable(
              accessor: (data) => dateFormat.format(data.timestamp),
              scale: OrdinalScale(tickCount: 5)),
          'Температура': Variable(accessor: (data) => data.temperature)
        },
        elements: [
          AreaElement(
              shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
              color: ColorAttr(value: Defaults.colors10.first.withAlpha(80))),
          LineElement(
              shape: ShapeAttr(value: BasicLineShape(smooth: true)),
              size: SizeAttr(value: 0.5))
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        selections: {
          'touchMove': PointSelection(
            on: {
              GestureType.scaleUpdate,
              GestureType.tapDown,
              GestureType.longPressMoveUpdate
            },
            dim: 1,
          )
        },
        tooltip: TooltipGuide(
          followPointer: [false, true],
          align: Alignment.topLeft,
          offset: const Offset(-20, -20),
        ),
        coord:
            RectCoord(onHorizontalRangeSignal: Defaults.horizontalRangeSignal),
      ),
    );
  }
}
