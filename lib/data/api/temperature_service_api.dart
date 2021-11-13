import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:temperature_viewer/data/api/temperature_service_exception.dart';
import 'package:temperature_viewer/data/model/sensor_data_request.dart';

class TemperatureServiceApiClient {
  final http.Client _httpClient;

  TemperatureServiceApiClient({http.Client? client})
      : _httpClient = client ?? http.Client();

  Uri _getUri(String url, String path) => Uri.http(url, path);

  Future<List<Map<String, dynamic>>> getRawSensorsList(String url) async {
    final uri = Uri.http(url, '/sensor/');
    final sensorsResponse = await _httpClient.get(uri);

    if (sensorsResponse.statusCode != 200) {
      throw SensorListRequestFailure();
    }

    return jsonDecode(utf8.decode(sensorsResponse.bodyBytes));
  }

  Future<List<dynamic>> getRawSensorData(
      String url, int sensorId, SensorDataRequest? params) async {
    final uri = params == null
        ? _getUri(url, '/reading/$sensorId')
        : _getUri(url, '/reading/$sensorId/filter?$params');
    final dataResponse = await _httpClient.get(uri);

    if (dataResponse.statusCode != 200) {
      throw SensorDataRequestFailure();
    }

    return jsonDecode(utf8.decode(dataResponse.bodyBytes));
  }

  Future<dynamic> getRawSensorDetail(String url, int sensorId) async {
    final uri = _getUri(url, '/sensor/$sensorId');
    final sensorResponse = await _httpClient.get(uri);

    if (sensorResponse.statusCode != 200) {
      throw SensorDetailRequestFailure();
    }

    return jsonDecode(utf8.decode(sensorResponse.bodyBytes));
  }
}
