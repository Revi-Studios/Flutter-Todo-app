import 'package:flutter/material.dart';
import 'package:flutter_todo_app/methods/task_related.dart';
import 'package:flutter_todo_app/views/settings.dart';
import 'package:flutter_todo_app/views/todo.dart';

void main() {
  runApp(const MyApp());
  setTaskListFromStorage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      themeMode: ThemeMode.system,
      routes: {
        '/settings': (context) => SettingsPage(),
      },
      home: TodoPage(),
    );
  }
}
