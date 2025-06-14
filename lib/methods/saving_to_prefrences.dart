import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
      ["Error", DateTime.now(), false],
    ];
  }

  List<dynamic> taskFromJsonToList = jsonDecode(taskIsJson);

  return taskFromJsonToList;
}


// Method for clearing the task list data
Future<void> clearListDataFromStorage(String key) async {
  saveListToStorage(key, []);
}