import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData(colorScheme: ColorScheme.dark(primary: Colors.white)),
      routes: {
        '/task_creation': (context) => TaskCreationPage(),
      },
      home: TodoPage(home: ''),

    );
  }
}


class TodoPage extends StatelessWidget {

  final String home;

  const TodoPage({super.key, required this.home,});


  String todoPageTitle() {
    if (home == '') {
      return ('Todo');
    } else {
      return ('Todo ($home)');
    }
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todoPageTitle()),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

      drawer: Drawer(),

      body: Column(
        children: [
        ],
      ),


      floatingActionButton: FloatingActionButton(
          onPressed:() => Navigator.pushNamed(context, '/task_creation'),
          child: Icon(Symbols.add),
      ),

      

    );
  }
}


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
