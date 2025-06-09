import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),

      body: ListView(
        children: [

          SwitchSettingsPare(title: 'Dark Mode', subTitle: 'Turns on or off dark mode in the app', isToggled: true,),

          Divider(),

          // SwitchSettingsPare(title: 'Send Notifications', subTitle: 'Sends or stops the sending of notifications', isToggled: true,),

          // Divider(),



        ],
      ),
    );
  }
}

class SwitchSettingsPare extends StatefulWidget {

  final String title;

  final String? subTitle;

  final bool? isToggled;

  

  const SwitchSettingsPare({super.key, required this.title, this.subTitle, this.isToggled, });

  @override
  State<SwitchSettingsPare> createState() => _SwitchSettingsPareState(title: title, subTitle: subTitle, isToggled: isToggled);
}

class _SwitchSettingsPareState extends State<SwitchSettingsPare> {

  final String title;

  final String? subTitle;

  bool? isToggled;

  _SwitchSettingsPareState({required this.title, this.subTitle, this.isToggled});

  ifNotNull({var value, String type = 'String'}) {
    switch (type) {
      case 'String':
          if (value == null) {
            return ('');
          } else {
            return value;
          }
      case 'bool':
          if (value == null) {
            return (false);
          } else {
            return value;
          }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: Switch(

        thumbIcon: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Icon>{WidgetState.selected: Icon(Symbols.check), WidgetState.any: Icon(Symbols.close)}),

      value: ifNotNull(value: isToggled, type: "bool"), 

      onChanged: (bool newValue) {
        setState(() {
          isToggled = newValue;
        });
      }),

      title: Text(ifNotNull(value: title)),

      subtitle: Text(ifNotNull(value: subTitle)),
      


    );
  }
}