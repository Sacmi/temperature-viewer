import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';
import 'package:temperature_viewer/logic/messaging.dart';
import 'package:temperature_viewer/presentation/route/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  initializeDateFormatting('ru_RU', null);

  final cloudMessaging = CloudMessaging();
  cloudMessaging.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final router = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: MaterialApp.router(
        title: 'Температура',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate:
            RoutemasterDelegate(routesBuilder: (_) => router.routes),
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }
}
