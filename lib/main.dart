import 'package:flutter/material.dart';
import 'package:flutter_todo_app/consts/prefrence_data.dart';
import 'package:flutter_todo_app/methods/task_related.dart';
import 'package:flutter_todo_app/views/todo.dart';

void main() {
  runApp(const MyApp());
  setTaskListFromStorage();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  void updateWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.white70,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.black,
          tertiary: const Color.fromARGB(156, 44, 44, 44),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
      themeMode: prefrenceData.theme,
      // routes: {
      //   '/settings': (context) => SettingsPage(),
      // },
      home: TodoPage(appRebuildMethod: updateWidget,),
    );
  }
}
