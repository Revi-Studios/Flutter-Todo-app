import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/views/todo.dart';

// Future<void> _selectedDate(BuildContext context, DateTime? controller) async {
//   final DateTime? _selectedDate = await showDatePicker(
//     context: context, 
//     firstDate: DateTime.now(), 
//     lastDate: DateTime(3000, 1, 1)
//   ); 

//   controller = _selectedDate;
// }




class TaskCreationPage extends StatelessWidget {
  TaskCreationPage({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();



  void addTask(String title, String description) async {
    taskList = await loadListFromStorage(taskListStorageKey);
    taskList.add({'title': title, 'description': description, 'checked': false});
    await saveListToStorage(taskListStorageKey, taskList);
    taskListWidgetRebuild();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Create Task'), centerTitle: true,),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          
          Text('Enter a title for the task:'),
            
          TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'), controller: _titleController, focusNode: _titleFocusNode,),
            
          TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description'), controller: _descriptionController,),
            
          // OutlinedButton(onPressed: () {}, style: ButtonStyle(), child: Text('Select Date'), ),
          
          FilledButton(
            child: Text('Create Task'),
            onPressed:() {
            if (_titleController.text != "") {
              addTask(_titleController.text, _descriptionController.text);
              Navigator.pop(context);
            } else {
              _titleFocusNode.requestFocus();
            }
            }, 
          )


        ],
      ),
      
    );
  }
}

