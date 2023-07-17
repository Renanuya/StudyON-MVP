import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thinktank/core/constants/navigation/navigation_constants.dart';
import 'package:thinktank/core/utils/navigation/navigation_service.dart';
import 'package:thinktank/pages/components/main_outlinedbutton.dart';

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  State<BlogHomePage> createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Study',
            style: GoogleFonts.pacifico(
              fontSize: mHeight * 0.04,
              color: const Color(0xFF37352f),
            ),
            children: const [
              TextSpan(
                text: 'On',
                style: TextStyle(
                  color: Color.fromARGB(255, 101, 191, 107),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Theme.of(context).brightness == Brightness.dark
                  ? Image.asset('assets/images/blogpage.png',
                      height: mHeight * 0.4, width: mWidth * 0.9)
                  : Image.asset('assets/images/blogpage.png',
                      height: mHeight * 0.4, width: mWidth * 0.9),
              const SizedBox(height: 50),
              SizedBox(
                width: 348,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Yarıçap değerini burada ayarlayın
                      ),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstants.secondBrainPage);
                  },
                  child: const Text('Second Brain Çalışma Tekniği'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 348,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Yarıçap değerini burada ayarlayın
                      ),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.instance
                        .navigateToPage(path: NavigationConstants.feynmanPage);
                  },
                  child: const Text('Feynman Çalışma Tekniği'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 348,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Yarıçap değerini burada ayarlayın
                      ),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.instance
                        .navigateToPage(path: NavigationConstants.pomodoroPage);
                  },
                  child: const Text('Pomodoro Çalışma Tekniği'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
