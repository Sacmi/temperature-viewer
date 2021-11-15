import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temperature_viewer/data/model/sensor_data.dart';
import 'package:temperature_viewer/data/model/sensor_data_request.dart';
import 'package:temperature_viewer/data/repository/sensor_data_repository.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

part 'sensor_data_state.dart';

class SensorDataCubit extends Cubit<SensorDataState> {
  final SettingsCubit settingsCubit;
  late final StreamSubscription _settingsCubitSubscription;
  final SensorDataRepository _repository = SensorDataRepository();

  String? url;

  SensorDataCubit({required this.settingsCubit})
      : super(SensorDataInitialLoading()) {
    url = settingsCubit.state.url;

    _settingsCubitSubscription = settingsCubit.stream.listen((state) {
      url = state.url;
    });
  }

  void getSensorData(
      {required int sensorId, DateTime? from, DateTime? to}) async {
    if (url == null) return emit(SensorDataFailure());

    emit(SensorDataLoading());

    try {
      final sensorData = await _repository.getSensorData(
          url!, sensorId, SensorDataRequest(from: from, to: to));

      emit(SensorDataLoaded(sensorData: sensorData, from: from, to: to));
    } on Exception {
      emit(SensorDataFailure());
    }
  }

  @override
  Future<void> close() {
    _settingsCubitSubscription.cancel();
    return super.close();
  }
}
