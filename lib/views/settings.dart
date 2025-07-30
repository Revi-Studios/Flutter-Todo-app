import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:flutter_todo_app/widgets/switch_settings_pare.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

      body: Expanded(
        child: ListView(
          children: [
            SwitchSettingsPare(
              title: 'Dark Mode',
              subTitle: 'Turns on or off dark mode in the app',
              isToggled: userPrefrenceData.userData["settings"]["darkmode"],
              onChanged: (newValue) {
                userPrefrenceData.userData["settings"]["darkmode"] = newValue;
                userPrefrenceData.saveData();
                appRebuildMethod();
              },
            ),

            // // Divider(indent: 50, endIndent: 50),
            // SwitchSettingsPare(
            //   title: 'Show descriptions',
            //   subTitle: 'Show the descriptions',
            //   isToggled: true,
            //   onChanged: (newValue) {},
            // ),

            // Divider(
            //   indent: 50,
            //   endIndent: 50,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      title: Text("Delete App Data"),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.tertiaryContainer,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'By clicking "Delete" you delete all user data. All your data will be lost',
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            userPrefrenceData.userData.clear();
                            await userPrefrenceData.saveData();
                            await userPrefrenceData.init();
                            SystemNavigator.pop();
                          },
                          label: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          icon: Icon(Symbols.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
                label: Text(
                  "Delete all data",
                  style: TextStyle(color: Colors.red),
                ),
                icon: Icon(Symbols.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
