import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/timer_data_model.dart';

class TimerDataProiver extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  TimerDataModel _model =
      TimerDataModel(allTime: 0, weekly: 0, monthly: 0, daily: 0);
  TimerDataModel get getModel => _model;
  void setAllTime(TimerDataModel? model, String? uid) {
    if (model != null && uid != null) {
      final userRef = _firestore.collection('timerdata').doc(uid);
      if (userRef.id.isNotEmpty) {
        userRef.set(model.toMap());
      }
    }
  }

  void getAllTime(String uid) {
    final reponse = _firestore.collection('timerdata').doc(uid).get();
    reponse.then(
      (value) {
        if (value.exists) {
          _model = TimerDataModel.fromMap(value.data() as Map<String, dynamic>);
          notifyListeners();
        }
      },
    );
  }
}
