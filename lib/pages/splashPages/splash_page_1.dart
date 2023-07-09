import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thinktank/core/utils/navigation/navigation_service.dart';
import 'package:thinktank/pages/components/main_outlinedbutton.dart';

import '../../core/constants/navigation/navigation_constants.dart';

class SplashPageOne extends StatelessWidget {
  const SplashPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ThinkTank',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: mHeight * 0.044,
            // color: const Color(0xFF37352f),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //! Görsel düzenlenecek
              Theme.of(context).brightness == Brightness.dark
                  ? Image.asset('assets/images/image_1_dark.png',
                      height: mHeight * 0.4, width: mWidth * 0.9)
                  : Image.asset('assets/images/image_1.png',
                      height: mHeight * 0.4, width: mWidth * 0.9),
              Text(
                //! Yazı düzenlenecek
                'Öğrenmeye birlikte adım atın!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: mHeight * 0.04,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mWidth * 0.0884, vertical: mHeight * 0.0204),
                child: Text(
                  //! Yazı düzenlenecek
                  'ThinkThank ile başarıya giden yolda yanınızdayız. Motive edici bir ortam ile öğrenmeyi keyifli hale getirin. Siz çalışırken biz sizin yanınızdayız. Hoş geldiniz!',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: mHeight * 0.0215,
                    // color: const Color(0xFF37352f),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: mHeight * 0.0091,
                  bottom: mHeight * 0.0059,
                  left: mWidth * 0.0884,
                  right: mWidth * 0.0884,
                ),
                child: MainOutlinedButton(
                  text: 'Devam et',
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashPageTwo()),
                    );*/
                    NavigationService.instance.navigateToPage(
                      path: NavigationConstants.splashPageTwo,
                    );
                  },
                  textSize: 0.023,
                ),
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
                    //  color: const Color(0xFF37352f),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
