import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thinktank/services/firestore_user_creation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signUp(
      String name, String surname, String email, String password) async {
    try {
      // Create the user with email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update current user info
      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName('$name $surname');
        await user.updateEmail(email);
      }

      // Add the new user to the 'users' collection in Firestore
      await FirestoreUserCreationService()
          .createUser(user!.uid, name, surname, email);
    } catch (e) {
      // User registration failed, display an error message
      // You can handle different error cases as needed
      String errorMessage = 'An error occurred during registration.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      // Handle the error or show a snackbar with the error message
      // _showSnackBar(errorMessage);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sign in successful, return the user credential
      User? user = userCredential.user;
    } catch (e) {
      // Sign in failed, display an error message
      // You can handle different error cases as needed
      String errorMessage = 'An error occurred during sign in.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      // Handle the error or show a snackbar with the error message
      // _showSnackBar(errorMessage);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

// Get the user object
        final User? user = userCredential.user;

        if (user != null) {
          // Retrieve additional user details from the Google account
          final String displayName = user.displayName ?? '';
          final String email = user.email ?? '';
          final String uid = user.uid;

          // Split the displayName into first and last names
          final List<String> nameParts = displayName.split(' ');
          String firstName = '';
          String lastName = '';

          if (nameParts.isNotEmpty) {
            firstName = nameParts.first;
            lastName = nameParts.length > 1 ? nameParts.last : '';
          }

          // Add the new user to the 'users' collection in Firestore
          await FirestoreUserCreationService()
              .createUser(uid, firstName, lastName, email);
        }
      }
    } catch (e) {
      // Sign in with Google failed, display an error message
      // You can handle different error cases as needed
      String errorMessage = 'An error occurred during sign in with Google.';
      print(errorMessage);
      // Handle the error or show a snackbar with the error message
      // _showSnackBar(errorMessage);
    }
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (query.docs.isNotEmpty) {
        return _auth.currentUser;
      }
      return null;
    } catch (e) {
      throw e;
    }
  }
}
