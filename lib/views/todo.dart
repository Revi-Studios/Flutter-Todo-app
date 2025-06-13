import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),

      drawerEdgeDragWidth: 100,

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/task_creation'),
        child: Icon(Symbols.add),
      ),

      body: TaskList(),
    );
  }
}



// Task List Data
List<dynamic> taskList = [
  ["Walk with my dogs", DateTime.now().toIso8601String(), false,],
  // ["Make food", DateTime.friday, false],
  // ["Play piano", DateTime.now(), false],
  // ["Meet a friend", DateTime.now() , false],
  // ["Hello", DateTime.now(), true],
];


// Method for saving the Task data
Future<void> saveListToStorage(String key, List<dynamic> list) async {
  final prefs = await SharedPreferences.getInstance();
  String taskToJson = json.encode(list);

  await prefs.setString(key, taskToJson);
}


// Methoed for getting/loading/retrieving Task data
Future<List<dynamic>> loadListFromStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();

  final String? taskIsJson = prefs.getString(key);

  if (taskIsJson == null) {
    return <List<dynamic>>[
      ["Test", true],
    ];
  }

  List<dynamic> taskFromJsonToList = jsonDecode(taskIsJson);

  return taskFromJsonToList;
}



Future<List<dynamic>> taskReturner() async {
  await saveListToStorage("taskListData", taskList);
  List<dynamic> loadedList = await loadListFromStorage("taskListData");
  await Future.delayed(const Duration(milliseconds: 500));
  loadedList.add(["Testing the List.add", DateTime.now().toIso8601String(), true]);
  return loadedList;
}



//Task List Widget

Future<Widget> createTaskListItem() async {
  List taskListFromStorage = await taskReturner();

   return ListView.builder(
          itemCount: taskListFromStorage.length,
          itemBuilder: (context, index) {
            return TaskTile(
              title: taskListFromStorage[index][0],
              date:  DateTime.parse(taskListFromStorage[index][1]),
              checked: taskListFromStorage[index][2],
            );
          },
        );
}


class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createTaskListItem(),
      initialData: TaskTile(title: "initTile", date: DateTime.now(), checked: true),

      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading the list, Error: ${snapshot.error.toString()}, date: ${DateTime.now().toString()}", style: TextStyle(color: Colors.red,)));
        } else {
          return Text("Something unexpected happened");
        }
      }
    );
  }
}

// Task Tile

class TaskTile extends StatefulWidget {
  final String title;

  DateTime date;

  bool checked;

  TaskTile({
    super.key,
    required this.title,
    required this.date,
    required this.checked,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.checked,
        onChanged: (value) {
          setState(() {
            widget.checked = !widget.checked;
          });
        },
      ),

      title: Text(
        widget.title,
        style: TextStyle(
          decoration: widget.checked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),

      subtitle: Text(widget.date.toString()),
    );
  }
}
