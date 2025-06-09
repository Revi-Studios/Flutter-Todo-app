import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';


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

