import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:temperature_viewer/logic/cubit/sensors_list/sensor_list_cubit.dart';

class SensorListView extends StatelessWidget {
  const SensorListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список датчиков'),
        actions: [
          IconButton(
              onPressed: () {
                Routemaster.of(context).push('/settings');
              },
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                BlocProvider.of<SensorListCubit>(context).getSensorList();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<SensorListCubit, SensorListState>(
        builder: (context, state) {
          if (state is SensorListFailure) {
            return const Center(
              child: Text('Не удалось загрузить список датчиков :('),
            );
          } else if (state is SensorListLoading) {
            if (state is SensorListInitialLoading) {
              BlocProvider.of<SensorListCubit>(context).getSensorList();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SensorListLoaded) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.sensors[index].label),
                    subtitle: Text(state.sensors[index].uuid),
                    onTap: () {
                      Routemaster.of(context)
                          .push('/${state.sensors[index].id}');
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.sensors.length);
          }

          return const Center(
            child: Text('Что-то произошло не так :\'('),
          );
        },
      ),
    );
  }
}
