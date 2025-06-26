import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/task_related.dart';

class TaskCreationPage extends StatelessWidget {
  TaskCreationPage({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();


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

