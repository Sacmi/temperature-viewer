import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temperature_viewer/logic/cubit/settings/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: переделать это говно
    final settingsCubit = context.watch<SettingsCubit>();
    textController.text = settingsCubit.state.url;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: 'Хост'),
          ),
          ElevatedButton(
              onPressed: () {
                settingsCubit.setUrl(textController.text);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
