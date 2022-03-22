// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  var firebaseService = GetIt.I<FirebaseService>();
  FirebaseAuth get auth => firebaseService.firebaseAuth;
//   init() {
//     auth = firebaseService.firebaseAuth;
//   }

  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      // create new user with email and password
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Future.value(true);
    } on FirebaseAuthException {
      // error when create user.
      rethrow;
    }
  }

  @override
  Future<bool> checkEmailValid(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      print("list email: ${list.length}");

      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return Future.value(true);
      } else {
        // Return false because email adress is not in use
        return Future.value(false);
      }
    } catch (error) {
      return Future.value(true);
    }
  }

  @override
  Future<bool> verifyEmail(String email) async {
    return Future.value(true);
  }
}
