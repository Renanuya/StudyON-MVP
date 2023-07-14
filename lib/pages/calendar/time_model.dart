import 'package:flutter/material.dart';

class TimeModel extends ChangeNotifier {
  DateTime time;

  TimeModel({required this.time});

  void updateTime(DateTime newTime) {
    time = newTime;
    notifyListeners();
  }
}
