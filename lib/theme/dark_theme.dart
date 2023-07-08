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
    surface: Color(0xffD3D3D3),
    onSurface: Color(0xffD3D3D3),
    //
    tertiary: Color(0xff37352F),
    onTertiary: Color(0xff37352F),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xffD3D3D3),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      surfaceTintColor: Colors.transparent,
      foregroundColor: const Color(0xffD3D3D3),
      side: const BorderSide(
        color: Color.fromARGB(255, 113, 112, 112),
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
        color: Color(0xffD3D3D3),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  ),
);