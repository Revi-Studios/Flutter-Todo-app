// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/methods/task_related.dart';
import 'package:flutter_todo_app/widgets/task_title.dart';
import 'package:material_symbols_icons/symbols.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  void updateTaskList() {
    setState(() {
      taskListAndItems = createTaskListAndItems();
    });
  }

  final _titleController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionController = TextEditingController();

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
        onPressed: () => showModalBottomSheet(
          showDragHandle: true,
          // isScrollControlled: true,
          useSafeArea: false,
          context: context,
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text("Create new task"),
                  TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'Title' ), controller: _titleController, focusNode: _titleFocusNode,),
                  TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description'), controller: _descriptionController,),
                  FilledButton(onPressed: () {addTask(_titleController.text, _descriptionController.text); Navigator.pop(context);}, child: Text("Create Task"))
                ],
              ),
            ),
          ),
        ),
        child: Icon(Symbols.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: taskListAndItems,
                initialData: TaskTile(
                  title: "initTile",
                  description: "in",
                  checked: true,
                  index: 0,
                ),
        
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return snapshot.data!;
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error loading the list, Error: ${snapshot.error.toString()}, date: ${DateTime.now().toString()}",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Text("Something unexpected happened");
                  }
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      clearListDataFromStorage(taskListStorageKey);
                      updateTaskList();
                    },
                    child: Text("Clear all"),
                  ),
        
                  IconButton(
                    onPressed: () => updateTaskList(),
                    icon: Icon(Symbols.refresh),
                  ),
        
                  IconButton(
                    onPressed: () {
                      addTask("nice task", "this is a nice task :)");
                      updateTaskList();
                    },
                    icon: Icon(Symbols.list),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final String taskListStorageKey = "taskListData";

// Task List Data
List<dynamic> taskList = [
  {
    'title': 'Test Task',
    'description': 'This is a test Task ',
    'checked': false,
  },
  {
    'title': 'nice task',
    'description': 'this is a nice task :)',
    'checked': true,
  },
];

//Task List Widget
Future<Widget> createTaskListAndItems() async {
  taskList = await loadListFromStorage(taskListStorageKey);
  return ListView.builder(
    shrinkWrap: true,
    itemCount: taskList.length,
    itemBuilder: (context, index) {
      return TaskTile(
        title: taskList[index]['title'],
        description: taskList[index]['description'],
        checked: taskList[index]['checked'],
        index: index,
      );
    },
  );
}

Future<Widget> taskListAndItems = createTaskListAndItems();
