import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_todo_app/methods/page_slide_animation_route.dart';
import 'package:flutter_todo_app/views/todo.dart';
import 'package:flutter_todo_app/widgets/switch_settings_pare.dart';
import 'package:flutter_todo_app/classes/prefrence_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

// An controller controlling if the user has passed the firs intro page so the app know if you have selected a theme and no longer use the system theme
class IntroductionPageController {
  bool finishedFirstPage = false;
}

// First introduktion page/screen showing an image and a slogan
class FirstIntroductionPage extends StatelessWidget {
  final VoidCallback appRebuildMethod;
  final IntroductionPageController introductionPageController;

  const FirstIntroductionPage({
    super.key,
    required this.appRebuildMethod,
    required this.introductionPageController,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final Widget startScreen = Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: SvgPicture.asset(
                "assets/images/task_man.svg",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Simple Task",
                    textHeightBehavior: TextHeightBehavior(
                      applyHeightToLastDescent: false,
                    ),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Managment",
                    textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                    ),
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "A simple and minimalistic todo app for you.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, right: 30),
                  child: Hero(
                    tag: "button",
                    child: SizedBox(
                      height: 40,
                      child: FilledButton.icon(
                        onPressed: () {
                          introductionPageController.finishedFirstPage = true;
                          Theme.brightnessOf(context) == Brightness.dark
                              ? userPrefrenceData
                                        .userData["settings"]["darkmode"] =
                                    true
                              : userPrefrenceData
                                        .userData["settings"]["darkmode"] =
                                    false;
                          appRebuildMethod();
                          Navigator.push(
                            context,
                            pageSlideAnimationRoute(
                              child: SecondIntroductionPage(
                                appRebuildMethod: appRebuildMethod,
                              ),
                            ),
                          );
                        },
                        label: Text(
                          " Setup ",
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        ),
                        icon: Icon(Symbols.arrow_forward),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return startScreen;
  }
}

// Second introduktion page/screen being a setup page where you can change you theme
class SecondIntroductionPage extends StatelessWidget {
  final VoidCallback appRebuildMethod;

  const SecondIntroductionPage({super.key, required this.appRebuildMethod});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Setup",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Theme:", style: TextStyle(fontSize: 20)),
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchSettingsPare(
                          title: 'Dark Mode',
                          subTitle: 'Turns on or off dark mode in the app',
                          isToggled: userPrefrenceData
                              .userData["settings"]["darkmode"],
                          onChanged: (newValue) {
                            userPrefrenceData.userData["settings"]["darkmode"] =
                                newValue;
                            userPrefrenceData.saveData();
                            appRebuildMethod();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, right: 30),
                  child: Hero(
                    tag: "button",
                    child: SizedBox(
                      height: 40,
                      child: FilledButton.icon(
                        onPressed: () async {
                          userPrefrenceData.userData["finished-introduktion"] =
                              true;
                          await userPrefrenceData.saveData();
                          await userPrefrenceData.init();
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoPage(
                                  appRebuildMethod: appRebuildMethod,
                                ),
                              ),
                            );
                            appRebuildMethod();
                          }
                        },
                        label: Text("Finish", maxLines: 1),
                        icon: Icon(Symbols.check),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
