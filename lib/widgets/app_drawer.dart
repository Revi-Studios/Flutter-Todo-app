import 'package:flutter/material.dart';
import 'package:flutter_todo_app/views/settings.dart';
import 'package:flutter_todo_app/views/todo.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.widget});

  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Text('App drawer')),

          ListTile(
            leading: Icon(Symbols.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SettingsPage(appRebuildMethod: widget.appRebuildMethod),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Symbols.info),
          //   title: Text("About"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => AboutPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
