import 'package:flutter/material.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:flutter_todo_app/views/introduction.dart';
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

  IntroductionPageController introductionPageController =
      IntroductionPageController();

  // Widget get introductionPage {
  //   Theme.brightnessOf(context) == Brightness.dark
  //       ? userPrefrenceData.userData["settings"]["darkmode"] = true
  //       : userPrefrenceData.userData["settings"]["darkmode"] = false;
  //   return IntroductionPage(
  //     appRebuildMethod: updateWidget,
  //     finishedFirstPage: finishedFirstPage,
  //   );
  // }

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
          onSecondaryContainer: const Color.fromARGB(158, 231, 231, 231),

          tertiary: const Color.fromARGB(255, 246, 246, 246),
          tertiaryContainer: const Color.fromARGB(255, 244, 244, 244),
        ),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: <TargetPlatform, PageTransitionsBuilder>{
        //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        //   },
        // ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          surface: Colors.black,

          primary: const Color.fromARGB(255, 239, 239, 239),
          onPrimary: Colors.black,
          onPrimaryContainer: Colors.white,

          secondary: const Color.fromARGB(255, 10, 10, 10),
          onSecondaryContainer: const Color.fromARGB(255, 31, 31, 31),

          tertiary: const Color.fromARGB(156, 44, 44, 44),
          tertiaryContainer: const Color.fromARGB(199, 32, 32, 32),
        ),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: <TargetPlatform, PageTransitionsBuilder>{
        //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        //   },
        // ),
      ),
      themeMode:
          userPrefrenceData.userData["finished-introduktion"] ||
              introductionPageController.finishedFirstPage
          ? userPrefrenceData.theme
          : ThemeMode.system,
      // routes: {
      //   '/settings': (context) => SettingsPage(),
      // },
      home: userPrefrenceData.userData["finished-introduktion"]
          ? TodoPage(appRebuildMethod: updateWidget)
          : FirstIntroductionPage(
              appRebuildMethod: updateWidget,
              introductionPageController: introductionPageController,
            ),
    );
  }
}
