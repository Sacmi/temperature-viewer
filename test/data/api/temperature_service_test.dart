import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:temperature_viewer/data/api/temperature_service_api.dart';
import 'package:temperature_viewer/data/api/temperature_service_exception.dart';
import 'package:temperature_viewer/data/model/sensor.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('TemperatureServiceApiClient', () {
    late http.Client httpClient;
    late TemperatureServiceApiClient temperatureServiceApiClient;
    const mockURL = 'localhost';

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      temperatureServiceApiClient =
          TemperatureServiceApiClient(client: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(TemperatureServiceApiClient(), isNotNull);
      });
    });

    group('sensorList', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await temperatureServiceApiClient.getRawSensorsList(mockURL);
        } catch (_) {}

        verify(() => httpClient.get(Uri.https('localhost', '/sensor/')))
            .called(1);
      });

      test('throws SensorListRequestFailure on non 200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
            () async =>
                await temperatureServiceApiClient.getRawSensorsList(mockURL),
            throwsA(isA<SensorListRequestFailure>()));
      });

      test('returns sensor list on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          [
    {
        "createdAt": "2021-11-13T11:07:45.661813Z",
        "id": 1,
        "label": "First sensor",
        "uuid": "1"
    },
    {
        "createdAt": "2021-11-13T11:07:52.676816Z",
        "id": 2,
        "label": "Second sensor",
        "uuid": "2"
    },
    {
        "createdAt": "2021-11-13T11:07:54.404767Z",
        "id": 3,
        "label": "Third sensor",
        "uuid": "3"
    }
]
        ''');

        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual =
            await temperatureServiceApiClient.getRawSensorsList(mockURL);

        expect(actual.length, 3);

        expect(
            actual.first,
            isA<Sensor>()
                .having((s) => s.id, 'id', 1)
                .having((s) => s.label, 'label', 'First sensor')
                .having((s) => s.uuid, 'uuid', '1')
                .having((s) => s.createdAt, 'createdAt',
                    DateTime.parse('2021-11-13T11:07:45.661813Z')));
      });
    });
  });
}
