import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temperature_viewer/data/model/sensor_detail.dart';
import 'package:temperature_viewer/data/repository/sensor_detail_repository.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

part 'sensor_detail_state.dart';

class SensorDetailCubit extends Cubit<SensorDetailState> {
  final SettingsCubit settingsCubit;
  late final StreamSubscription _settingsCubitSubscription;
  final SensorDetailRepository _repository = SensorDetailRepository();

  String? url;

  SensorDetailCubit({required this.settingsCubit})
      : super(SensorDetailLoading()) {
    _settingsCubitSubscription = settingsCubit.stream.listen((state) {
      url = state.url;
    });
  }

  void getSensorDetail({required int sensorId}) async {
    if (url == null) return emit(SensorDetailFailure());

    emit(SensorDetailLoading());

    try {
      final sensorDetail = await _repository.getSensorDetail(url!, sensorId);
      emit(SensorDetailLoaded(sensorDetail: sensorDetail));
    } on Exception {
      emit(SensorDetailFailure());
    }
  }

  @override
  Future<void> close() {
    _settingsCubitSubscription.cancel();
    return super.close();
  }
}
