import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/pages/register/model/request_model.dart';

import '../../../core/constants/enums/provider_enums.dart';

class RegisterUserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Status? _isSucces;

  Status? get getIsSucces => _isSucces;

  void setUserRequestModel(RegisterRequestModel model) async {
    _isSucces = Status.loading;
    notifyListeners();
    final UserCredential response;
    try {
      if (model.email != null && model.password != null) {
        response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: model.email!, password: model.password!);
        if (response.user?.email != null) {
          await response.user
              ?.updateDisplayName('${model.name} ${model.surname}');
          await _firestore.collection('users').doc(response.user?.uid).set({
            'name': model.name,
            'surname': model.surname,
            'email': model.email,
          });
          await _firestore.collection('timerdata').doc(response.user?.uid).set({
            'daily': 0,
            'weekly': 0,
            'monthly': 0,
            'allTime': 0,
          });
        }
        if (response.user != null) {
          _isSucces = Status.success;
          notifyListeners();
        } else {
          _isSucces = Status.failed;
          notifyListeners();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == Status.emailAlreadyInUse.value) {
        _isSucces = Status.emailAlreadyInUse;
        notifyListeners();
      } else if (e.code == Status.weakPassword.value) {
        _isSucces = Status.weakPassword;
        notifyListeners();
      } else if (e.code == Status.wrongPassword.value) {
        _isSucces = Status.wrongPassword;
        notifyListeners();
      } else if (e.code == Status.userNotFound.value) {
        _isSucces = Status.userNotFound;
        notifyListeners();
      } else if (e.code == Status.passwordNotMatch.value) {
        _isSucces = Status.passwordNotMatch;
        notifyListeners();
      } else {
        _isSucces = Status.failed;
        notifyListeners();
      }
    }
  }
}

class RegisterPasswordVisibilityProvider extends ChangeNotifier {
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  bool get getPasswordVisibility => _passwordVisibility;
  bool get getConfirmPasswordVisibility => _confirmPasswordVisibility;

  void setPasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void setConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }
}
