import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thinktank/core/constants/enums/provider_enums.dart';

import '../model/user_model.dart';

class PickProfilePhoto extends ChangeNotifier {
  Status? _status;
  UserModel _model = const UserModel();

  Status? get getStatus => _status;
  UserModel get getUserModel => _model;

  Future<void> uploadProfilePhoto(XFile? file) async {
    if (FirebaseAuth.instance.currentUser != null && file != null) {
      _status = Status.loading;
      final ref = FirebaseStorage.instance
          .ref('users')
          .child('${FirebaseAuth.instance.currentUser!.uid}/userpp.jpg');

      final uploadTask = ref.putFile(File(file.path));

      final snapshot = await uploadTask.whenComplete(() {});

      final url = await snapshot.ref.getDownloadURL();
      if (url.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'ppUrl': url,
        });
        _status = Status.success;
        notifyListeners();
      }
    } else {
      _status = Status.failed;
      notifyListeners();
    }
  }

  Future<void> fetchProfileInfos() async {
    final response = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (response.exists) {
      final model = UserModel.fromMap(response.data() as Map<String, dynamic>);
      if (model.name != null) {
        _model = model;
        notifyListeners();
      }
    }
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickFromGallery() async {
    XFile? result = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 60);

    if (result == null) return;

    if (result.path.isNotEmpty) {
      uploadProfilePhoto(result);
    }
  }

  Future<void> pickFromCamera() async {
    XFile? result = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 60);

    if (result == null) return;

    if (result.path.isNotEmpty) {
      uploadProfilePhoto(result);
    }
  }
}
