part of 'sensor_data_cubit.dart';

abstract class SensorDataState extends Equatable {
  const SensorDataState();

  @override
  List<Object> get props => [];
}

class SensorDataLoading extends SensorDataState {}

class SensorDataLoaded extends SensorDataState {
  final List<SensorData> sensorData;

  const SensorDataLoaded({
    required this.sensorData,
  });

  @override
  List<Object> get props => [sensorData];
}

class SensorDataFailure extends SensorDataState {}
