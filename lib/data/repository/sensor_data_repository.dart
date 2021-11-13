import 'package:temperature_viewer/data/api/temperature_service_api.dart';
import 'package:temperature_viewer/data/model/sensor_data.dart';
import 'package:temperature_viewer/data/model/sensor_data_request.dart';

class SensorDataRepository {
  final TemperatureServiceApiClient _temperatureServiceApiClient;

  SensorDataRepository(
      {TemperatureServiceApiClient? temperatureServiceApiClient})
      : _temperatureServiceApiClient =
            temperatureServiceApiClient ?? TemperatureServiceApiClient();

  Future<List<SensorData>> getSensorData(
      String url, int sensorId, SensorDataRequest params) async {
    final _params = params.from == null && params.to == null ? null : params;

    final jsonSensorData = await _temperatureServiceApiClient.getRawSensorData(
        url, sensorId, _params);

    return List.generate(jsonSensorData.length,
        (index) => SensorData.fromMap(jsonSensorData[index]));
  }
}
