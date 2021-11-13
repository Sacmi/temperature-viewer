import 'package:temperature_viewer/data/api/temperature_service_api.dart';
import 'package:temperature_viewer/data/model/sensor.dart';

class SensorListRepository {
  final TemperatureServiceApiClient _temperatureServiceApiClient;

  SensorListRepository(
      {TemperatureServiceApiClient? temperatureServiceApiClient})
      : _temperatureServiceApiClient =
            temperatureServiceApiClient ?? TemperatureServiceApiClient();

  Future<List<Sensor>> getSensorList(String url) async {
    final sensorsJson =
        await _temperatureServiceApiClient.getRawSensorsList(url);

    return List.generate(
        sensorsJson.length, (index) => Sensor.fromMap(sensorsJson[index]));
  }
}
