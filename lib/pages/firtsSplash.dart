import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:thinktank/core/constants/navigation/navigation_constants.dart';
import 'package:thinktank/core/utils/navigation/navigation_service.dart';

class FirstSplashPage extends StatefulWidget {
  const FirstSplashPage({super.key});

  @override
  State<FirstSplashPage> createState() => _FirstSplashPageState();
}

class _FirstSplashPageState extends State<FirstSplashPage> {
  double opacityLevel = 0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2000), () {
      NavigationService.instance
          .navigateToPageRemoveAll(path: NavigationConstants.authPage);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacityLevel = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Color.fromARGB(255, 101, 191, 107),
      Color.fromARGB(255, 255, 255, 255),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xff191919)
          : Color.fromARGB(255, 237, 237, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  speed: const Duration(milliseconds: 200),
                  'StudyOn',
                  textStyle: GoogleFonts.pacifico(
                    fontSize: 50,
                  ),
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
