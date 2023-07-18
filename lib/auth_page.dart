import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/pages/homePage/view/home_page.dart';
import 'package:thinktank/pages/login/view/login_page.dart';
import 'package:thinktank/pages/profileSettingPage/profilePage/profile_screen.dart';
import 'package:thinktank/pages/rankPages/view/rank_page.dart';
import 'package:thinktank/pages/splashPages/splash_page_1.dart';
import 'package:thinktank/pages/splashPages/splash_page_3.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else if (FirebaseAuth.instance.currentUser == null) {
          return const LoginPage();
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
