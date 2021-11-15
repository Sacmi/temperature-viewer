part of 'sensor_detail_cubit.dart';

abstract class SensorDetailState extends Equatable {
  const SensorDetailState();

  @override
  List<Object> get props => [];
}

class SensorDetailLoading extends SensorDetailState {}

class SensorDetailInitialLoading extends SensorDetailLoading {}

class SensorDetailLoaded extends SensorDetailState {
  final SensorDetail sensorDetail;

  const SensorDetailLoaded({
    required this.sensorDetail,
  });

  @override
  List<Object> get props => [sensorDetail];
}

class SensorDetailFailure extends SensorDetailState {}
