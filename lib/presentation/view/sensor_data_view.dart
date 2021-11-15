import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:temperature_viewer/logic/cubit/sensor_data/sensor_data_cubit.dart';
import 'package:temperature_viewer/presentation/component/chart.dart';
import 'package:temperature_viewer/presentation/component/date_range_text.dart';

class SensorDataView extends StatelessWidget {
  const SensorDataView({required this.sensorId, Key? key}) : super(key: key);

  final int sensorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Данные датчика'), actions: [
        IconButton(
            onPressed: () {
              Routemaster.of(context).push('/$sensorId/config');
            },
            icon: const Icon(Icons.settings))
      ]),
      body: BlocBuilder<SensorDataCubit, SensorDataState>(
        builder: (context, state) {
          if (state is SensorDataLoading) {
            if (state is SensorDataInitialLoading) {
              BlocProvider.of<SensorDataCubit>(context)
                  .getSensorData(sensorId: sensorId);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SensorDataLoaded) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('Промежуток времени'),
                  subtitle: DateRangeText(
                    from: state.from,
                    end: state.to?.subtract(const Duration(days: 1)),
                  ),
                  onTap: () async {
                    final range = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2021, 1, 1),
                        lastDate: DateTime.now());

                    if (range != null) {
                      BlocProvider.of<SensorDataCubit>(context).getSensorData(
                          sensorId: sensorId,
                          from: range.start,
                          to: range.end.add(const Duration(days: 1)));
                    }
                  },
                ),
                TemperatureChart(
                  sensorData: state.sensorData,
                )
              ],
            );
          } else if (state is SensorDataFailure) {
            return const Center(
              child: Text('Не удалось получить показания с датчика.'),
            );
          }

          return const Text('???');
        },
      ),
    );
  }
}
