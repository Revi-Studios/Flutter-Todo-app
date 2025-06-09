import 'package:flutter/material.dart';

class TaskCreationPage extends StatelessWidget {
  const TaskCreationPage({super.key});

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

              TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'), controller: TextEditingController(),),

              TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description'),),

              OutlinedButton(
                onPressed: () {showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000, 1, 1)); }, 
                style: ButtonStyle(),
                
                
                child: Text('Select Date'),
                ),
              
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: FilledButton(onPressed:() {
                  
                }, child: Text('Create Task')),
              )


            ],
          ),
        )


        ),
      
    );
  }
}

