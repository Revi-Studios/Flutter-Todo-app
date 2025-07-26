import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:flutter_todo_app/widgets/switch_settings_pare.dart';

class SettingsPage extends StatelessWidget {
  final ThemeData? themeData;
  final VoidCallback appRebuildMethod;

  const SettingsPage({
    super.key,
    this.themeData,
    required this.appRebuildMethod,
  });

  // Variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),

      body: ListView(
        children: [
          SwitchSettingsPare(
            title: 'Dark Mode',
            subTitle: 'Turns on or off dark mode in the app',
            isToggled: true,
            onChanged: (newValue) => {
              if (newValue == true)
                {userPrefrenceData.theme = ThemeMode.dark, appRebuildMethod()}
              else /*if (newValue == false)*/
                {userPrefrenceData.theme = ThemeMode.light, appRebuildMethod()},
            },
          ),

          Divider(),

          SwitchSettingsPare(
            title: 'Send Notifications',
            subTitle: 'Sends or stops the sending of notifications',
            onChanged: (newValue) {},
          ),

          Divider(),
        ],
      ),
    );
  }
}
