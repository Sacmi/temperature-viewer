import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

void main() {
  group('SettingsCubit', () {
    late SettingsCubit settingsCubit;

    setUp(() async {
      HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: await getTemporaryDirectory());
      settingsCubit = SettingsCubit();
    });

    tearDown(() {
      settingsCubit.close();
    });

    test('initial state of SettingsCubit is SettingsCubit(url: "")', () {
      expect(settingsCubit.state, const SettingsState(url: ''));
    });

    blocTest<SettingsCubit, SettingsState>(
        'the SettingsCubit should emit a state with new url when the setUrl function is called',
        build: () => settingsCubit,
        act: (cubit) => cubit.setUrl('test_url.com'),
        expect: () => [const SettingsState(url: 'test_url.com')]);
  });
}
