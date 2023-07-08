import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/pages/login/viewmodel/view_model.dart';
import 'package:thinktank/pages/register/viewmodel/view_model.dart';
import 'package:thinktank/pages/splashPages/splash_page_1.dart';
import 'package:thinktank/providers/theme.dart';
import 'package:thinktank/theme/dark_theme.dart';
import 'package:thinktank/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:thinktank/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Disable persistence on web platforms. Must be called on initialization:

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeChange()),
        ChangeNotifierProvider(create: (context) => RegisterUserProvider()),
        ChangeNotifierProvider(
            create: (context) => RegisterPasswordVisibilityProvider()),
        ChangeNotifierProvider(
            create: (context) => LoginPasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeChange>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeChange.currentTheme ?? lightTheme,
        darkTheme: themeChange.currentTheme ?? darkTheme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const SplashPageOne();
            }
          },
        ));
  }
}
