// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<ThemeData?> getThemeFromSave() async {
    final preferences = await _prefs;
    final theme = preferences.getString('theme');
    if (theme?.isNotEmpty ?? false) {
      switch (theme) {
        case 'lightTheme':
          return lightTheme;
        case 'darkTheme':
          return darkTheme;
      }
    }
    return null;
  }

  void saveTheme(String value) {
    _prefs.then((SharedPreferences preferences) {
      preferences.setString('theme', value);
    });
  }

  void setRemoveSavedTheme() {
    _prefs.then((SharedPreferences preferences) {
      preferences.remove('theme');
    });
  }
}
