// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temperature_viewer/logic/cubit/sensor_detail/sensor_detail_cubit.dart';

class SensorDetailView extends StatelessWidget {
  final int sensorId;

  final maxTempController = TextEditingController();
  final minTempController = TextEditingController();
  final sendDelayController = TextEditingController();
  final updateDelayController = TextEditingController();
  final labelController = TextEditingController();

  SensorDetailView({required this.sensorId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка датчика'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SensorDetailCubit, SensorDetailState>(
          builder: (context, state) {
            if (state is SensorDetailLoading) {
              if (state is SensorDetailInitialLoading) {
                BlocProvider.of<SensorDetailCubit>(context)
                    .getSensorDetail(sensorId: sensorId);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SensorDetailFailure) {
              return const Center(
                child: Text('Не удалось получить данные'),
              );
            } else if (state is SensorDetailLoaded) {
              labelController.text = state.sensorDetail.label;
              minTempController.text = state.sensorDetail.minTemp.toString();
              maxTempController.text = state.sensorDetail.maxTemp.toString();
              sendDelayController.text =
                  state.sensorDetail.sendDelay.toString();
              updateDelayController.text =
                  state.sensorDetail.updateDelay.toString();

              return ListView(
                children: [
                  TextField(
                      controller: labelController,
                      decoration:
                          const InputDecoration(labelText: 'Название датчика')),
                  TextField(
                      controller: minTempController,
                      decoration: const InputDecoration(
                          labelText: 'Минимальная температура')),
                  TextField(
                      controller: maxTempController,
                      decoration: const InputDecoration(
                          labelText: 'Максимальная температура')),
                  TextField(
                      controller: sendDelayController,
                      decoration: const InputDecoration(
                          labelText: 'Интервал отправки показаний')),
                  TextField(
                      controller: updateDelayController,
                      decoration: const InputDecoration(
                          labelText: 'Интервал проверки настроек')),
                  ListTile(
                    title: const Text('Сохранить'),
                    leading: const Icon(Icons.save),
                    onTap: () {
                      context.read<SensorDetailCubit>().updateSensorDetail(
                          sensorId: sensorId,
                          label: labelController.text,
                          minTemp: double.parse(minTempController.text),
                          maxTemp: double.parse(maxTempController.text),
                          sendDelay: int.parse(sendDelayController.text),
                          updateDelay: int.parse(updateDelayController.text));
                    },
                  )
                ],
              );
            } else {
              return const Text('???');
            }
          },
        ),
      ),
    );
  }
}
