// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  var firebaseService = GetIt.I<FirebaseService>();
  var sharedPref = GetIt.I<AppSharedPreference>();
  late FirebaseAuth auth;
  init() {
    auth = firebaseService.firebaseAuth;
  }

  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<LoginState> authLogin(String email, String password) async {
    //TODO: Get and save token
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // sharedPref.saveString(AppConstant.keyPrefToken, await FirebaseAuth.instance)

    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   return LoginState.failed;
      // } else if (e.code == 'wrong-password') {
      //   return LoginState.failed;
      // }
      return LoginState.failed;
    }
    return LoginState.successful;
  }

  @override
  Future<LoginState> authLogoutYet() async {
    LoginState status = LoginState.loading;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        status = LoginState.failed;
      } else {
        status = LoginState.successful;
      }
    });
    return status;
  }

  @override
  Future<LoginState> checkToken() async {
    LoginState status = LoginState.pending;
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        status = LoginState.tokenFailed;
      } else {
        status = LoginState.successful;
      }
    });
    return status;
  }
}
