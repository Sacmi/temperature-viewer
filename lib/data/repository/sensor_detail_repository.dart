import 'package:temperature_viewer/data/api/temperature_service_api.dart';
import 'package:temperature_viewer/data/model/sensor_detail.dart';
import 'package:temperature_viewer/data/model/sensor_detail_update.dart';

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

  Future<SensorDetail> updateSensorDetail(
      String url, int sensorId, SensorDetailUpdate update) async {
    final jsonUpdatedSensor = await _temperatureServiceApiClient
        .updateRawSensorDetail(url, sensorId, update);

    return SensorDetail.fromMap(jsonUpdatedSensor);
  }
}
