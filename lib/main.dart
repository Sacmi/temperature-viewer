import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temperature_viewer/logic/cubit/sensor_data/sensor_data_cubit.dart';
import 'package:temperature_viewer/logic/cubit/sensor_detail/sensor_detail_cubit.dart';
import 'package:temperature_viewer/logic/cubit/sensors_list/sensor_list_cubit.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(
            create: (context) => SensorListCubit(
                settingsCubit: BlocProvider.of<SettingsCubit>(context))),
        BlocProvider(
            create: (context) => SensorDataCubit(
                settingsCubit: BlocProvider.of<SettingsCubit>(context))),
        BlocProvider(
            create: (context) => SensorDetailCubit(
                settingsCubit: BlocProvider.of<SettingsCubit>(context)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context) {
              final state = context.watch<SensorDetailCubit>().state;

              if (state is SensorDetailLoading) {
                return const Text('Loading');
              } else if (state is SensorDetailFailure) {
                return const Text('Bad :(');
              } else if (state is SensorDetailLoaded) {
                return Text('Length is ${state.sensorDetail.label}');
              } else {
                return const Text('???');
              }
            }),
            Builder(builder: (context) {
              final urlValue =
                  context.select((SettingsCubit cubit) => cubit.state.url);

              return Text(
                urlValue,
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<SettingsCubit>(context).setUrl('192.168.1.2:8080');
          BlocProvider.of<SensorDetailCubit>(context)
              .getSensorDetail(sensorId: 3);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
