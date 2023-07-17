import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/pages/homePage/model/timer_data_model.dart';

import '../model/rank_data_list_model.dart';

class RankUserListDataProviderAllTime extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  int _userRank = 0;

  List<RankDataListModel> _listModel = [];
  List<RankDataListModel>? get getModel => _listModel;
  int get getUserRank => _userRank;
  bool _ready = false;
  bool get getReady => _ready;

  void rankUser(String uid) {
    if (_listModel.isNotEmpty) {
      _listModel.sort(
        (a, b) => (b.allTime ?? 0).compareTo(a.allTime ?? 0),
      );
      final currentRank =
          _listModel.indexWhere((element) => element.uid == uid);
      _userRank = currentRank + 1;
    }
    _ready = true;
    notifyListeners();
  }

  Future<void> setList() async {
    final reponse = await _firestore.collection('timerdata').get();
    final docs = reponse.docs;

    if (docs.isNotEmpty) {
      for (var item in docs) {
        final user = await _firestore.collection('users').doc(item.id).get();
        final data = TimerDataModel.fromMap(item.data());
        if (data.allTime != null && user.exists) {
          _listModel.add(
            RankDataListModel(
                name: user.data()?['name'],
                surname: user.data()?['surname'],
                allTime: data.allTime,
                weekly: data.weekly,
                monthly: data.monthly,
                daily: data.daily,
                uid: item.id),
          );
        }
      }
    }
    rankUser(FirebaseAuth.instance.currentUser?.uid ?? '');
  }
}

class RankUserListDataProviderWeekly extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  int _userRank = 0;

  List<RankDataListModel> _listModel = [];
  List<RankDataListModel>? get getModel => _listModel;
  int get getUserRank => _userRank;
  bool _ready = false;
  bool get getReady => _ready;

  void rankUser(String uid) {
    if (_listModel.isNotEmpty) {
      _listModel.sort(
        (a, b) => (b.weekly ?? 0).compareTo(a.weekly ?? 0),
      );
      final currentRank =
          _listModel.indexWhere((element) => element.uid == uid);
      _userRank = currentRank + 1;
    }
    _ready = true;
    notifyListeners();
  }

  Future<void> setList() async {
    final reponse = await _firestore.collection('timerdata').get();
    final docs = reponse.docs;

    if (docs.isNotEmpty) {
      for (var item in docs) {
        final user = await _firestore.collection('users').doc(item.id).get();
        final data = TimerDataModel.fromMap(item.data());
        if (data.allTime != null && user.exists) {
          _listModel.add(
            RankDataListModel(
                name: user.data()?['name'],
                surname: user.data()?['surname'],
                allTime: data.allTime,
                weekly: data.weekly,
                monthly: data.monthly,
                daily: data.daily,
                uid: item.id),
          );
        }
      }
    }
    rankUser(FirebaseAuth.instance.currentUser?.uid ?? '');
  }
}

class RankUserListDataProviderMonthly extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  int _userRank = 0;

  List<RankDataListModel> _listModel = [];
  List<RankDataListModel>? get getModel => _listModel;
  int get getUserRank => _userRank;
  bool _ready = false;
  bool get getReady => _ready;

  void rankUser(String uid) {
    if (_listModel.isNotEmpty) {
      _listModel.sort(
        (a, b) => (b.monthly ?? 0).compareTo(a.monthly ?? 0),
      );
      final currentRank =
          _listModel.indexWhere((element) => element.uid == uid);
      _userRank = currentRank + 1;
    }
    _ready = true;
    notifyListeners();
  }

  Future<void> setList() async {
    final reponse = await _firestore.collection('timerdata').get();
    final docs = reponse.docs;

    if (docs.isNotEmpty) {
      for (var item in docs) {
        final user = await _firestore.collection('users').doc(item.id).get();
        final data = TimerDataModel.fromMap(item.data());
        if (data.allTime != null && user.exists) {
          _listModel.add(
            RankDataListModel(
                name: user.data()?['name'],
                surname: user.data()?['surname'],
                allTime: data.allTime,
                weekly: data.weekly,
                monthly: data.monthly,
                daily: data.daily,
                uid: item.id),
          );
        }
      }
    }
    rankUser(FirebaseAuth.instance.currentUser?.uid ?? '');
  }
}
