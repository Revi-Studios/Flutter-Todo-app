// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:flutter_todo_app/classes/task_list_options_controller.dart';
import 'package:flutter_todo_app/widgets/app_drawer.dart';
import 'package:flutter_todo_app/widgets/task_filter_chip.dart';
import 'package:flutter_todo_app/widgets/task_list.dart';
import 'package:material_symbols_icons/symbols.dart';

class TodoPage extends StatefulWidget {
  final VoidCallback appRebuildMethod;
  const TodoPage({super.key, required this.appRebuildMethod});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  void rebuildWidget() {
    setState(() {});
  }

  // String buttonText() {
  //   if ((_titleController.text.trim() == "") &&
  //       (_descriptionController.text.trim() == "")) {
  //     dynamicButtonText.text = "Close";
  //     return "Close";
  //   } else {
  //     dynamicButtonText.text = "Clear";
  //     return "Clear";
  //   }
  // }

  // final TextEditingController dynamicButtonText = TextEditingController();

  String get dynamicButtonText {
    return _titleController.text.trim() == "" &&
            _descriptionController.text.trim() == ""
        ? "Cancel"
        : "Clear";
  }

  final _titleController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _taskFilteringChipsController = TaskListOptionsController();

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

      drawer: AppDrawer(widget: widget),

      drawerEdgeDragWidth: 100,

      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,

            useSafeArea: true,
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
                        onChanged: (value) => setState(() {}),
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
                            flex: 2,
                            child: OutlinedButton(
                              onPressed: () => dynamicButtonText == "Clear"
                                  ? {
                                      _titleController.text = "",
                                      _descriptionController.text = "",
                                    }
                                  : Navigator.of(context).pop(),
                              child: Text(dynamicButtonText),
                            ),
                          ),

                          Expanded(
                            flex: 5,
                            child: FilledButton(
                              onPressed: () {
                                if (_titleController.text.trim() != "") {
                                  if (!userPrefrenceData.defaultTaskList
                                      .containsKey(
                                        _titleController.text.trim(),
                                      )) {
                                    Navigator.pop(context);
                                    userPrefrenceData.defaultTaskList.addAll({
                                      _titleController.text.trim(): {
                                        "title": _titleController.text.trim(),
                                        "description": _descriptionController
                                            .text
                                            .trim(),
                                        "checked": false,
                                      },
                                    });
                                    userPrefrenceData.saveData();
                                    rebuildWidget();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        margin: EdgeInsets.all(10.0),
                                        behavior: SnackBarBehavior.floating,
                                        showCloseIcon: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        content: Text(
                                          "A task with the title: \"${_titleController.text}\" already exists!",
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  _titleFocusNode.requestFocus();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      margin: EdgeInsets.all(10.0),
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Text(
                                        "Enter a valid title for the task!",
                                      ),
                                    ),
                                  );
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
              child: TaskFilteringChips(
                controller: _taskFilteringChipsController,
                onChanged: () => rebuildWidget(),
              ),
            ),

            Flexible(
              child: TaskList(
                taskList: userPrefrenceData.defaultTaskListasList,
                options: _taskFilteringChipsController,
                widgetRebuildMethod: rebuildWidget,
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       IconButton.filled(
            //         onPressed: () => userPrefrenceData.saveData(),
            //         icon: Icon(Symbols.refresh),
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       TextButton(
            //         onPressed: () {
            //           clearListDataFromStorage(taskListStorageKey);
            //         },
            //         child: Text("Clear all"),
            //       ),

            //       IconButton(
            //         onPressed: () => updateTaskList(),
            //         icon: Icon(Symbols.refresh),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
