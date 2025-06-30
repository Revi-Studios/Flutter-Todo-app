import 'package:flutter/material.dart';

class TaskFutureBuilder extends StatefulWidget {
  final Future<Widget> taskList;

  const TaskFutureBuilder({super.key, required this.taskList});

  @override
  State<TaskFutureBuilder> createState() => _TaskFutureBuilderState();
}

class _TaskFutureBuilderState extends State<TaskFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.taskList,

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
    );
  }
}