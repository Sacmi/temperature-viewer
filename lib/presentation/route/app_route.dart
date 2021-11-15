import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:temperature_viewer/logic/cubit/sensor_data/sensor_data_cubit.dart';
import 'package:temperature_viewer/logic/cubit/sensor_detail/sensor_detail_cubit.dart';
import 'package:temperature_viewer/logic/cubit/sensors_list/sensor_list_cubit.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';
import 'package:temperature_viewer/presentation/view/sensor_data_view.dart';
import 'package:temperature_viewer/presentation/view/sensor_detail.dart';
import 'package:temperature_viewer/presentation/view/sensor_list_view.dart';
import 'package:temperature_viewer/presentation/view/settings_view.dart';

class AppRouter {
  final routes = RouteMap(routes: {
    '/': (_) => MaterialPage(
            child: BlocProvider(
          create: (context) => SensorListCubit(
              settingsCubit: BlocProvider.of<SettingsCubit>(context)),
          child: const SensorListView(),
        )),
    '/:id': (info) => MaterialPage(
            child: BlocProvider(
          create: (context) => SensorDataCubit(
              settingsCubit: BlocProvider.of<SettingsCubit>(context)),
          child: SensorDataView(
            sensorId: int.parse(info.pathParameters['id']!),
          ),
        )),
    '/:id/config': (info) => MaterialPage(
            child: BlocProvider(
          create: (context) => SensorDetailCubit(
              settingsCubit: BlocProvider.of<SettingsCubit>(context)),
          child:
              SensorDetailView(sensorId: int.parse(info.pathParameters['id']!)),
        )),
    '/settings': (_) => MaterialPage(child: SettingsView())
  });
}
