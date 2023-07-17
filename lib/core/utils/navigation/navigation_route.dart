import 'package:flutter/material.dart';
import 'package:thinktank/auth.dart';
import 'package:thinktank/pages/blogPages/blog_home_page.dart';
import 'package:thinktank/pages/blogPages/blog_topics/blog_topic_feynman.dart';
import 'package:thinktank/pages/blogPages/blog_topics/blog_topic_pomodoro.dart';
import 'package:thinktank/pages/blogPages/blog_topics/blog_topic_secondbrain.dart';
import 'package:thinktank/pages/calendar/create_event_page.dart';

import 'package:thinktank/pages/homePage/view/home_page.dart';
import 'package:thinktank/pages/rankPages/view/rank_page.dart';
import 'package:thinktank/pages/splashPages/splash_page_1.dart';
import 'package:thinktank/pages/timerpage/view/timerscreen.dart';

import '../../../auth_page.dart';
import '../../../not_found.dart';
import '../../../pages/calendar/calendar_main_page.dart';
import '../../../pages/login/view/login_page.dart';
import '../../../pages/profileSettingPage/profilePage/profile_screen.dart';
import '../../../pages/register/view/register_page.dart';
import '../../../pages/register/view/reset_password.dart';
import '../../../pages/splashPages/splash_page_2.dart';
import '../../../pages/splashPages/splash_page_3.dart';

import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  NavigationRoute._init();
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Blog Pages
      case NavigationConstants.blogPage:
        return normalNavigate(
            const BlogHomePage(), NavigationConstants.blogPage);
      case NavigationConstants.secondBrainPage:
        return normalNavigate(
            const SecondBrainPage(), NavigationConstants.secondBrainPage);
      case NavigationConstants.feynmanPage:
        return normalNavigate(
            const FeynmanPage(), NavigationConstants.feynmanPage);
      case NavigationConstants.pomodoroPage:
        return normalNavigate(
            const PomodoroPage(), NavigationConstants.pomodoroPage);

      //profile Page
      case NavigationConstants.profilePage:
        return normalNavigate(
            const ProfilePage(), NavigationConstants.profilePage);

      //Splash Pages

      case NavigationConstants.splashPageOne:
        return normalNavigate(
            const SplashPageOne(), NavigationConstants.splashPageOne);
      case NavigationConstants.splashPageTwo:
        return normalNavigate(
            const SplashPageTwo(), NavigationConstants.splashPageTwo);
      case NavigationConstants.splashPageThree:
        return normalNavigate(
            const SplashPageThree(), NavigationConstants.splashPageThree);

      //Ranking Pages
      case NavigationConstants.rankingPage:
        return normalNavigate(
            const RankPage(), NavigationConstants.rankingPage);

      case NavigationConstants.timerPage:
        return normalNavigate(
            MainStopwatchScreen(
                goal: 'Hedefinizi Belirleyin',
                workingTime: 0,
                breakTime: 0,
                backgroundMusic: 'assets/sounds/askinolayim.mp3'),
            NavigationConstants.timerPage);

      //Calendar Pages
      case NavigationConstants.calendarPage:
        return normalNavigate(
            const CalendarMainPage(), NavigationConstants.calendarPage);
      case NavigationConstants.createTaskPage:
        return normalNavigate(
            CreateEventPage(
              selectedDate: DateTime.now(),
              selectedEvents: {},
            ),
            NavigationConstants.createTaskPage);

      //Login & Register Pages
      case NavigationConstants.loginPage:
        return normalNavigate(const LoginPage(), NavigationConstants.loginPage);
      case NavigationConstants.registerPage:
        return normalNavigate(
            const RegisterPage(), NavigationConstants.registerPage);
      case NavigationConstants.resetPassword:
        return normalNavigate(
            const ResetPassword(), NavigationConstants.resetPassword);
      case NavigationConstants.authPage:
        return normalNavigate(const AuthPage(), NavigationConstants.authPage);
      case NavigationConstants.auth:
        return normalNavigate(const Auth(), NavigationConstants.auth);

      //Other Pages
      case NavigationConstants.homePage:
        return normalNavigate(const HomePage(), NavigationConstants.homePage);
      case NavigationConstants.notFound:
        return normalNavigate(
            const NotFoundPage(), NavigationConstants.notFound);
      case NavigationConstants.splashPageOne:
        return normalNavigate(
            const SplashPageOne(), NavigationConstants.splashPageOne);
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NotFoundPage(),
        );
    }
  }

  MaterialPageRoute<dynamic> normalNavigate(
    Widget widget,
    String pageName, {
    Object? object,
  }) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName, arguments: object),
    );
  }
}

/* //Splash Pages
  static const String splashPageOne = '/splashPageOne';
  static const String splashPageTwo = '/splashPageTwo';
  static const String splashPageThree = '/splashPageThree';

  //Ranking Pages
  static const String rankingPage = '/rankingPage';

  //Timer Pages
  static const String timerPage = '/timerPage';

  //Calendar Pages
  static const String calendarPage = '/calendarPage';

  //login & Register Pages
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';

  //Other Pages
  static const String homePage = '/homePage';
  static const String notFound = '/notFound'; */