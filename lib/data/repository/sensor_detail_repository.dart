import 'package:temperature_viewer/data/api/temperature_service_api.dart';
import 'package:temperature_viewer/data/model/sensor_detail.dart';

class SensorDetailRepository {
  final TemperatureServiceApiClient _temperatureServiceApiClient;

  SensorDetailRepository(
      {TemperatureServiceApiClient? temperatureServiceApiClient})
      : _temperatureServiceApiClient =
            temperatureServiceApiClient ?? TemperatureServiceApiClient();

  Future<SensorDetail> getSensorDetail(String url, int sensorId) async {
    final jsonSensor =
        await _temperatureServiceApiClient.getRawSensorDetail(url, sensorId);

    return SensorDetail.fromMap(jsonSensor as Map<String, dynamic>);
  }
}
