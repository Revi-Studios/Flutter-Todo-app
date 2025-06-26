import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/views/todo.dart';

void reloadTaskList() async {
  taskList = await loadListFromStorage(taskListStorageKey);
}

void switchCheckedState(index, checked) async {
  reloadTaskList();
  taskList[index]['checked'] = checked;
  await saveListToStorage(taskListStorageKey, taskList);
}

void addTask(String title, String description) async {
  taskList = await loadListFromStorage(taskListStorageKey);
  taskList.add({'title': title, 'description': description, 'checked': false});
  await saveListToStorage(taskListStorageKey, taskList);
  // TodoPageState.updateTaskList();
}
