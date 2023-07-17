import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserCreationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String name, String surname, String email) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'surname': surname,
        'email': email,
      });

      // Create initial timer data for the user
      await _firestore.collection('timerdata').doc(uid).set({
        'daily': 0,
        'weekly': 0,
        'monthly': 0,
        'allTime': 0,
      });
    } catch (e) {
      // Handle the error or show a snackbar with the error message
      // _showSnackBar('An error occurred while creating the user in Firestore.');
    }
  }

  Future<void> saveWorkingTime(String uid, int workingTime) async {
    final DocumentReference documentRef = _firestore.collection('timerdata').doc(uid);

    final DocumentSnapshot documentSnapshot = await documentRef.get();
    if (documentSnapshot.exists) {
      // Document exists, update the workingTime field by incrementing the values
      await documentRef.update({
        'allTime': FieldValue.increment(workingTime),
        'daily': FieldValue.increment(workingTime),
        'weekly': FieldValue.increment(workingTime),
        'monthly': FieldValue.increment(workingTime),
      });
    } else {
      // Document does not exist, create it with the workingTime field
      await documentRef.set({
        'allTime': workingTime,
        'daily': workingTime,
        'weekly': workingTime,
        'monthly': workingTime,
      });
    }
  }

  Future<void> resetTimerData(String uid, {bool daily = true, bool weekly = true, bool monthly = true}) async {
    final collectionRef = _firestore.collection('timerdata').doc(uid);

    if (daily) {
      await collectionRef.update({
        'daily': 0,
      });
    }

    if (weekly) {
      await collectionRef.update({
        'weekly': 0,
      });
    }

    if (monthly) {
      await collectionRef.update({
        'monthly': 0,
      });
    }
  }
}



