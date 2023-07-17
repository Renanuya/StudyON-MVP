import 'package:flutter/material.dart';

class TimerPageBackgroundMusicProvider extends ChangeNotifier {
  static const Map<String, String> soundOptionsMap = {
    'Arkaplan sesi 1': 'sounds/campfire.m4a',
    'Arkaplan sesi 2': 'sounds/fragments.m4a',
    'Arkaplan sesi 3': 'sounds/insChill.m4a',
    'Arkaplan sesi 4': 'sounds/askinolayim.mp3',
  };
  Map<String, String> _selectedSound = soundOptionsMap;
  Map<String, String> get getSelectedSound => _selectedSound;

  set selectedSoundSet(Map<String, String> value) {
    _selectedSound = value;
    notifyListeners();
  }
}
