import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

PrefrenceData userPrefrenceData = PrefrenceData();

class PrefrenceData {

  final String taskListStorageKey = "taskListData";
  ThemeMode theme = ThemeMode.system;
  
  // a map taskList with the title of the task as key for the hole task so we can delete the tasks with a key and not an index
  Map<String, dynamic> taskList = {
    // "Title": {"title": "Title", "description": "Description", "checked": true},
    // "Title1": {"title": "Title1", "description": "Description", "checked": false},
    // "Title2": {"title": "Title1", "description": "Description", "checked": false},
    // "Title3": {"title": "Title1", "description": "Description", "checked": false}
  };

  // turns the taskList map into a list so we can use it in a listview builder
  List get taskListasList {return taskList.values.toList();}

  Future init() async {
    final prefs = await SharedPreferences.getInstance(); 
    final String? taskListToString = prefs.getString(taskListStorageKey);

    taskList = json.decode(taskListToString ?? "{}");
    return taskList;
  }


  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String taskListToString  = json.encode(taskList);

    await prefs.setString(taskListStorageKey, taskListToString);
  }
}