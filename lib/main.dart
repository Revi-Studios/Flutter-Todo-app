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
      // routes: {
      //   'createPage' (context) => CreateingPage()
      // },
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
          onPressed:() {
            // Navigator.pushNamed(context, 'createPage');
          },
          child: Icon(Symbols.add),
      ),

      

    );
  }
}