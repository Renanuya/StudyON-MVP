import 'package:flutter/material.dart';

class TimerPageBackgroundMusicProvider extends ChangeNotifier {
  final List<Map<String, String>> _soundOptionsMap = [
    {
      'Arkaplan sesi 1': 'sounds/campfire.m4a',
    },
    {'Arkaplan sesi 2': 'sounds/fragments.m4a'},
    {'Arkaplan sesi 3': 'sounds/insChill.m4a'},
    {'Arkaplan sesi 4': 'sounds/askinolayim.mp3'},
  ];
  Map<String, String> _soundOptionsMapNew = {
    'Arkaplan sesi 1': 'sounds/campfire.m4a',
  };
  Map<String, String> get getSelectedSound => _soundOptionsMapNew;
  set selectedSoundSet(int index) {
    _soundOptionsMapNew = _soundOptionsMap.elementAt(index);
    notifyListeners();
  }
}
