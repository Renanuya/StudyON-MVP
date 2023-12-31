import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thinktank/core/utils/navigation/navigation_service.dart';
import 'package:thinktank/pages/components/main_outlinedbutton.dart';
import '../../core/constants/navigation/navigation_constants.dart';

class SplashPageTwo extends StatelessWidget {
  const SplashPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Study',
                      style: GoogleFonts.pacifico(
                        fontSize: mHeight * 0.04,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xffD3D3D3)
                            : const Color(0xFF37352f),
                      ),
                      children: [
                        const TextSpan(
                          text: 'On',
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 191, 107),
                          ),
                        ),
                        TextSpan(
                          text: ' ile zamanını yönet!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mHeight * 0.035,
                            fontFamily: 'inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Theme.of(context).brightness == Brightness.dark
                    ? Image.asset('assets/images/splashpage2.png',
                        height: mHeight * 0.4, width: mWidth * 0.9)
                    : Image.asset('assets/images/splashpage2.png',
                        height: mHeight * 0.4, width: mWidth * 0.9),
                const SizedBox(
                  height: 90,
                ),
                MainOutlinedButton(
                  text: 'Devam et',
                  onPressed: () {
                    NavigationService.instance.navigateToPage(
                      path: NavigationConstants.splashPageThree,
                    );
                  },
                  textSize: 0.023,
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.instance.navigateToPage(
                      path: NavigationConstants.splashPageThree,
                    );
                  },
                  child: Text(
                    'geç',
                    style: GoogleFonts.inter(
                      fontSize: mHeight * 0.0193,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
