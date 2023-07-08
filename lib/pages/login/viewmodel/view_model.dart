import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:thinktank/core/constants/enums/provider_enums.dart';
import 'package:thinktank/pages/login/model/login_request_model.dart';

class UserLoginProvider extends ChangeNotifier {
  UserCredential? _model;
  Status? _loginStatus;

  UserCredential? get getLoginResponseModel => _model;
  Status? get getLoginIsSucces => _loginStatus;

  void userLoginWithEmailPassword(LoginRequestModel model) async {
    _loginStatus = Status.loading;
    notifyListeners();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (model.email != null && model.password != null) {
      try {
        final response = await firebaseAuth.signInWithEmailAndPassword(
            email: model.email!, password: model.password!);
        if (response.user != null) {
          _model = response;
          _loginStatus = Status.success;
          notifyListeners();
        } else {
          _loginStatus = Status.failed;
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == Status.wrongPassword.value) {
          _loginStatus = Status.wrongPassword;

          notifyListeners();
        } else if (e.code == Status.userNotFound.value) {
          _loginStatus = Status.userNotFound;
          notifyListeners();
        } else {
          _loginStatus = Status.failed;
          notifyListeners();
        }
      }
    }
  }
}

class LoginPasswordVisibilityProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void changePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
