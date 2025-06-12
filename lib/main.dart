import 'package:flutter/material.dart';
import 'package:flutter_todo_app/views/creation.dart';
import 'package:flutter_todo_app/views/settings.dart';
import 'package:flutter_todo_app/views/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.light(primary: Colors.black,), pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: PredictiveBackPageTransitionsBuilder()},),),
      darkTheme: ThemeData(colorScheme: ColorScheme.dark(primary: Colors.white,), pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: PredictiveBackPageTransitionsBuilder()},),),
      themeMode: ThemeMode.dark,
      routes: {
        '/task_creation': (context) => TaskCreationPage(),
        '/settings': (context) => SettingsPage(),
      },
      home: TodoPage(home: ''),

    );
  }
}