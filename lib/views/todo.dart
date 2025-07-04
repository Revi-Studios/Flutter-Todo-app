// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_todo_app/consts/task_list.dart';
import 'package:flutter_todo_app/consts/task_storage_key.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/methods/task_related.dart';
import 'package:flutter_todo_app/widgets/task_filter_chip.dart';
import 'package:flutter_todo_app/widgets/task_future_builder.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';
import 'package:material_symbols_icons/symbols.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {

  void updateTaskList() {
    setState(() {
      taskListAndItems = createTaskList(_taskFilteringChipsController.text);
    });
  }

  final _titleController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();

  final _taskFilteringChipsController = TextEditingController();

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
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,

            // useSafeArea: false,
            context: context,
            builder: (context) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        "Create Task",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        autofocus: true,
                        onSubmitted: (value) =>
                            _descriptionFocusNode.requestFocus(),
                      ),

                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        controller: _descriptionController,
                        focusNode: _descriptionFocusNode,
                      ),

                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                _titleController.text = "";
                                _descriptionController.text = "";
                              },
                              child: Text("Clear"),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: FilledButton(
                              onPressed: () {
                                if (_titleController.text != "") {
                                  createTaskInTaskList(
                                    _titleController.text,
                                    _descriptionController.text,
                                  );
                                  Navigator.pop(context);
                                  saveTaskListToStorage();
                                } else {
                                  _titleFocusNode.requestFocus();
                                }
                              },
                              child: Text("Create Task"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Symbols.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TaskFilteringChips(controller: _taskFilteringChipsController, onChange: () => updateTaskList(),),
            ),

            Flexible(child: TaskFutureBuilder(taskList: taskListAndItems)),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      clearListDataFromStorage(taskListStorageKey);
                    },
                    child: Text("Clear all"),
                  ),

                  IconButton(
                    onPressed: () => updateTaskList(),
                    icon: Icon(Symbols.refresh),
                  ),

                  IconButton(
                    onPressed: () {
                      createTaskInTaskList("nice task", "this is a nice task :)");
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

//Task List Widget
Future<Widget> createTaskList(String option) async {
  switch (option) {
    case "All":
      return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return TaskTile(title: taskList[index]['title'], description: taskList[index]["description"], checked: taskList[index]["checked"], index: index);
        });
    case "Done":
      return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          if (taskList[index]["checked"] == true) {
                return TaskTile(title: taskList[index]['title'], description: taskList[index]["description"], checked: taskList[index]["checked"], index: index);
          } else {
            return Container();
          }
        });
    case "Pending":
      return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          if (taskList[index]["checked"] != true) {
            return TaskTile(title: taskList[index]['title'], description: taskList[index]["description"], checked: taskList[index]["checked"], index: index);
          } else {
            return Container();
          }
        });    
    default:
      return Text("No option selected (in function)");
  }
}

Future<Widget> taskListAndItems = createTaskList("All");
