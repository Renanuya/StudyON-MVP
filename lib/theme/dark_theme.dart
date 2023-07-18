import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'inter',
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffD3D3D3),
    onPrimary: Color(0xffD3D3D3),
    secondary: Color(0xffD3D3D3),
    onSecondary: Color(0xffD3D3D3),
    error: Color(0xffDD4A48),
    onError: Color(0xffDD4A48),
    background: Color(0xff191919),
    //Scaffold Background
    onBackground: Color(0xff191919),
    //Scaffold Color and Cards
    surface: Color.fromARGB(255, 28, 28, 28),
    onSurface: Color.fromARGB(255, 170, 170, 170),

    tertiary: Color(0xff37352F),
    onTertiary: Color(0xff37352F),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xffD3D3D3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Color(0xff717070),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 178, 178, 178),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xffD3D3D3),
      side: const BorderSide(
        color: Color.fromARGB(255, 84, 84, 84),
        width: 1.5,
      ),
    ),
  ),
  cardTheme: const CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      side: BorderSide(
        color: Color.fromARGB(255, 84, 84, 84),
        width: 1.0,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.inter(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        backgroundColor: Colors.transparent,
        color: Color(0xffD3D3D3),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color(0xffD3D3D3),
    ),
  ),
);
