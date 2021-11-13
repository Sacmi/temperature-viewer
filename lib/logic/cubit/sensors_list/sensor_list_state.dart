part of 'sensor_list_cubit.dart';

abstract class SensorListState extends Equatable {
  const SensorListState();

  @override
  List<Object> get props => [];
}

class SensorListLoading extends SensorListState {
  @override
  List<Object> get props => [];
}

class SensorListLoaded extends SensorListState {
  final List<Sensor> sensors;

  const SensorListLoaded({required this.sensors});

  @override
  List<Object> get props => [sensors];
}

class SensorListFailure extends SensorListState {
  @override
  List<Object> get props => [];
}
