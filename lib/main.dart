import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:flutter_todo_app/views/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await userPrefrenceData.init();
  runApp(const MyApp());
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
      themeMode: userPrefrenceData.theme,
      // routes: {
      //   '/settings': (context) => SettingsPage(),
      // },
      home: TodoPage(appRebuildMethod: updateWidget,),
    );
  }
}
