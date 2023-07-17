import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Center(
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Study',
                style: GoogleFonts.pacifico(
                  fontSize: mHeight * 0.04,
                  color: const Color(0xFF37352f),
                ),
                children: [
                  const TextSpan(
                    text: 'On',
                    style: TextStyle(
                      color: Color.fromARGB(255, 101, 191, 107),
                    ),
                  ),
                  TextSpan(
                    text: ' ile çalışmaya başlayın!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mHeight * 0.035,
                      fontFamily: 'inter',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
