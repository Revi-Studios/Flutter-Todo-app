import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/task_list_options_controller.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';

enum TaskListOptions { all, done, pending }

class TaskList extends StatefulWidget {
  final List taskList;
  final TaskListOptionsController options;

  const TaskList({
    super.key,
    required this.taskList,
    required this.options,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  void rebuildWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskList.length,
      itemBuilder: (context, index) {
        // builds the tasks we want to see, [all, done, pending]
        switch (widget.options.value) {
          case TaskListOptions.all:
            return TaskTile(
              title: widget.taskList[index]['title'],
              description: widget.taskList[index]["description"],
              checked: widget.taskList[index]["checked"],
              updateMethod: () => rebuildWidget(),
            );
          case TaskListOptions.done:
            return widget.taskList[index]["checked"]
                ? TaskTile(
                    title: widget.taskList[index]['title'],
                    description: widget.taskList[index]["description"],
                    checked: widget.taskList[index]["checked"],
                    updateMethod: () => rebuildWidget(),
                  )
                : Container();
          case TaskListOptions.pending:
            return widget.taskList[index]["checked"]
                ? Container()
                : TaskTile(
                    title: widget.taskList[index]['title'],
                    description: widget.taskList[index]["description"],
                    checked: widget.taskList[index]["checked"],
                    updateMethod: () => rebuildWidget(),
                  );
        }
      },
    );
  }
}
