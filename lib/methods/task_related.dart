import 'package:flutter_todo_app/consts/task_list.dart';
import 'package:flutter_todo_app/consts/task_storage_key.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';

void setTaskListFromStorage() async {
  taskList = await loadListFromStorage(taskListStorageKey);
}

void saveTaskListToStorage() async {
  saveListToStorage(taskListStorageKey, taskList);
}

void switchCheckedState(index, checked) async {
  taskList[index]['checked'] = checked;
  await saveListToStorage(taskListStorageKey, taskList);
}

void createTaskInTaskList(String title, String description) {
  taskList.add({"title": title, "description": description, "checked": false});
}