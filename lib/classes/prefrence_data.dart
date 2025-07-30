import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

PrefrenceData userPrefrenceData = PrefrenceData();

class PrefrenceData {
  final String userDataStorageKey = "userData";

  final Map _defaultUserData = {
    "finished-introduktion": false,
    "settings": {"darkmode": false},
    "task-lists": {
      "default": {
        "Default": {"title": "Default", "description": "test", "checked": true},
      },
    },
  };

  late Map userData;

  // theme
  ThemeMode get theme {
    return userData["settings"]["darkmode"] ? ThemeMode.dark : ThemeMode.light;
  }

  // a map taskList with the title of the task as key for the hole task so we can delete the tasks with a key and not an index
  Map<String, dynamic> get defaultTaskList {
    return userData["task-lists"]["default"];
  }

  // turns the taskList map into a list so we can use it in a listview builder
  List get defaultTaskListasList {
    return defaultTaskList.values.toList();
  }

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? taskListToString = prefs.getString("userData");
    Map decodedUserData = await json.decode(taskListToString ?? "{}");

    userData = decodedUserData.toString() == "{}"
        ? _defaultUserData
        : decodedUserData;
  }

  Future saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String userDataAsString = json.encode(userData);

    await prefs.setString(userDataStorageKey, userDataAsString);
  }
}
