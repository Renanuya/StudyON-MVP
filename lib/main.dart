import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinktank/auth_page.dart';
import 'package:thinktank/core/utils/navigation/navigation_route.dart';
import 'package:thinktank/pages/homePage/viewmodel/home_page_viewmodel.dart';
import 'package:thinktank/pages/login/view/login_page.dart';
import 'package:thinktank/pages/login/viewmodel/view_model.dart';
import 'package:thinktank/pages/rankPages/veiwmodel/rank_view_model.dart';
import 'package:thinktank/pages/register/viewmodel/view_model.dart';
import 'package:thinktank/pages/splashPages/splash_page_1.dart';
import 'package:thinktank/pages/timerpage/view_model/view_model_timer.dart';
import 'package:thinktank/providers/event_provider.dart';
import 'package:thinktank/providers/theme.dart';
import 'package:thinktank/theme/dark_theme.dart';
import 'package:thinktank/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/navigation/navigation_service.dart';
import 'core/utils/show_snackbar.dart';
import 'firebase_options.dart';

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
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => TimerDataProiver()),
        ChangeNotifierProvider(
            create: (context) => RankUserListDataProviderAllTime()),
        ChangeNotifierProvider(
            create: (context) => RankUserListDataProviderMonthly()),
        ChangeNotifierProvider(
            create: (context) => RankUserListDataProviderWeekly()),
        ChangeNotifierProvider(
            create: (context) => TimerPageBackgroundMusicProvider())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool sawed = false;
  Future<void> sharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sawed = prefs.getBool('saw') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    sharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeChange>(context);
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      scaffoldMessengerKey: ShowSnackbar.instance.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: themeChange.currentTheme ?? lightTheme,
      darkTheme: themeChange.currentTheme ?? darkTheme,
      home: sawed ? const AuthPage() : const SplashPageOne(),
    );
  }
}
