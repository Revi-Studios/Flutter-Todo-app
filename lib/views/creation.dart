import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/saving_to_prefrences.dart';
import 'package:flutter_todo_app/views/todo.dart';

Future<void> _selectedDate(BuildContext context, DateTime? controller) async {
  final DateTime? _selectedDate = await showDatePicker(
    context: context, 
    firstDate: DateTime.now(), 
    lastDate: DateTime(3000, 1, 1)
  ); 

  controller = _selectedDate;
}




class TaskCreationPage extends StatelessWidget {
  TaskCreationPage({super.key});

  final _titleController = TextEditingController();
  final _dateController = DateTime(2000);


  void addTask(String title, DateTime date) async {
    taskList = await loadListFromStorage(taskListStorageKey);
    taskList.add([title, date.toIso8601String(), false]);
    await saveListToStorage(taskListStorageKey, taskList);
    taskListWidgetRebuild();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task'), centerTitle: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(

            children: [
              
              Text('Enter a title for the task:'),

              TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'), controller: _titleController,),

              // TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description'),),

              OutlinedButton(
                onPressed: () => _selectedDate(context, _dateController), 
                style: ButtonStyle(),
                
                
                child: Text('Select Date'),
                ),
              
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: FilledButton(onPressed:() {addTask(_titleController.text, _dateController); Navigator.pop(context);}, 
                child: Text('Create Task')),
              )


            ],
          ),
        )


        ),
      
    );
  }
}

