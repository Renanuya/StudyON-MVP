import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'inter',
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff37352F),
    onPrimary: Color(0xff37352F),
    secondary: Color(0xff37352F),
    onSecondary: Color(0xff37352F),
    error: Color(0xffDD4A48),
    onError: Color(0xffDD4A48),
    background: Color(0xffFFFFFF),
    //Scaffold Background
    onBackground: Color(0xffffffff),
    //Scaffold Color and Cards
    surface: Color(0xffF7F7F5),
    onSurface: Color(0xff37352F),
    //
    tertiary: Color(0xffF6F6F6),
    onTertiary: Color.fromARGB(255, 255, 255, 255),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color(0xffF7F7F5),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xff37352F),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color(0xffF7F7F5),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xff37352F),
      side: const BorderSide(
        color: Color(0xffE0E0DE),
        width: 1.5,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.inter(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        backgroundColor: Colors.transparent,
        color: Color(0xff37352F),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  ),
);