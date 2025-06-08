import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.light(primary: Colors.black)) ,
      darkTheme: ThemeData(colorScheme: ColorScheme.dark(primary: Colors.white,)),
      routes: {
        '/task_creation': (context) => TaskCreationPage(),
        '/settings': (context) => SettingsPage(),
      },
      home: TodoPage(home: ''),

    );
  }
}


class TodoPage extends StatelessWidget {

  final String home;

  const TodoPage({super.key, required this.home,});


  String todoPageTitle() {
    if (home == '') {
      return ('Todo');
    } else {
      return ('Todo ($home)');
    }
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todoPageTitle()),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

      drawer: Drawer(
        child: Column(
        children: [
          DrawerHeader(child: Text('App drawer')),

          ListTile(
            leading: Icon(Symbols.settings),
            title: Text('Settings'),
            onTap:() => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed:() => Navigator.pushNamed(context, '/task_creation'),
          child: Icon(Symbols.add),
      ),

      

    );
  }
}


class TaskCreationPage extends StatelessWidget {
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task'), centerTitle: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(

            children: [
              
              Text('Enter a title for the task:'),

              TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'), controller: TextEditingController(),),

              TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description'),),

              OutlinedButton(
                onPressed: () {showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000, 1, 1)); }, 
                style: ButtonStyle(),
                
                
                child: Text('Select Date'),
                ),
              
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: FilledButton(onPressed:() {
                  
                }, child: Text('Create Task')),
              )


            ],
          ),
        )


        ),
      
    );
  }
}


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