import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';


class TodoPage extends StatelessWidget {

  const TodoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 30, 
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          ),
        ),

      drawer: Drawer(
        child: Column(
        children: [
          DrawerHeader(child: Text('App drawer')),

          ListTile(
            leading: Icon(Symbols.settings),
            title: Text('Settings'),
            onTap:() {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed:() => Navigator.pushNamed(context, '/task_creation'),
          child: Icon(Symbols.add),
      ),

      body: TaskList()
      
    );
  }
}


//Task List Widget

class TaskList extends StatelessWidget {
  TaskList({super.key});

  List taskList = [
    ["Walk with my dogs", "I have to go outside and walk with my dogs for at least 20 min", true],
    ["Make food", "Until: 2024/06/15", false],
    ["Play piano", "Until: 2024/06/17", false],
    ["Meet a friend", "Until: 2024/06/19", false],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: taskList.length,

      itemBuilder:(context, index) {
        return TaskTile(
          title: taskList[index][0], 
          date: taskList[index][1],
          checked: taskList[index][2]
        );
      },
    
    
    );
  }
}


// Task Tile

class TaskTile extends StatefulWidget {

  final String title;

  final String date;
  
  bool checked;

  TaskTile({super.key, required this.title, required this.date, required this.checked});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.checked, 
        onChanged:(value) {
          setState(() {
            widget.checked = !widget.checked;
          });
        },
        ),

      title: Text(widget.title, style: TextStyle(decoration: widget.checked ? TextDecoration.lineThrough : TextDecoration.none),),

      subtitle: Text(widget.date),

    );
  }
}