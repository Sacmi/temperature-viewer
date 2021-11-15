part of 'sensor_data_cubit.dart';

abstract class SensorDataState extends Equatable {
  const SensorDataState();

  @override
  List<Object> get props => [];
}

class SensorDataLoading extends SensorDataState {}

class SensorDataInitialLoading extends SensorDataLoading {}

class SensorDataLoaded extends SensorDataState {
  final List<SensorData> sensorData;

  const SensorDataLoaded({required this.sensorData, this.from, this.to});

  final DateTime? from;
  final DateTime? to;

  @override
  List<Object> get props => [sensorData];
}

class SensorDataFailure extends SensorDataState {}
