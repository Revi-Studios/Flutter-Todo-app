import 'package:flutter/material.dart';
import 'package:flutter_todo_app/consts/task_list.dart';
import 'package:flutter_todo_app/widgets/task_tile.dart';

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