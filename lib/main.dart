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
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.white,
          secondary: const Color.fromARGB(255, 255, 255, 255),
          tertiary: const Color.fromARGB(255, 246, 246, 246),
          onSecondaryContainer: const Color.fromARGB(158, 231, 231, 231)

        ),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: <TargetPlatform, PageTransitionsBuilder>{
        //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        //   },
        // ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 239, 239, 239),
          secondary: const Color.fromARGB(255, 10, 10, 10),
          onSecondaryContainer: const Color.fromARGB(255, 31, 31, 31),
          surface: Colors.black,
          onPrimaryContainer: Colors.white,
          tertiary: const Color.fromARGB(156, 44, 44, 44),
        ),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: <TargetPlatform, PageTransitionsBuilder>{
        //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        //   },
        // ),
      ),
      themeMode: userPrefrenceData.theme,
      // routes: {
      //   '/settings': (context) => SettingsPage(),
      // },
      home: TodoPage(appRebuildMethod: updateWidget,),
    );
  }
}
