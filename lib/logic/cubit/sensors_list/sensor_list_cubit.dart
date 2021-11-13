import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temperature_viewer/data/model/sensor.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

import 'package:temperature_viewer/data/repository/sensor_list_repository.dart';

part 'sensor_list_state.dart';

class SensorListCubit extends Cubit<SensorListState> {
  final SettingsCubit settingsCubit;
  late final StreamSubscription _settingsCubitSubscription;
  final SensorListRepository _sensorListRepository = SensorListRepository();

  String? url;

  SensorListCubit({required this.settingsCubit}) : super(SensorListLoading()) {
    _settingsCubitSubscription = settingsCubit.stream.listen((state) {
      url = state.url;
    });
  }

  Future<void> getSensorList() async {
    if (url == null) return emit(SensorListFailure());

    emit(SensorListLoading());

    try {
      final sensorList = await _sensorListRepository.getSensorList(url!);
      emit(SensorListLoaded(sensors: sensorList));
    } on Exception {
      emit(SensorListFailure());
    }
  }

  @override
  Future<void> close() {
    _settingsCubitSubscription.cancel();
    return super.close();
  }
}
