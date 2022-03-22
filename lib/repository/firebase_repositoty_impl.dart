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
    sharedPref.getAppSharedPreference();
  }

  @override
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<LoginState> authLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        sharedPref.saveString(AppConstant.keyPrefToken, token);
      }
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
  Future<LoginState> checkToken() async {
    if (sharedPref.getString(AppConstant.keyPrefToken) ==
        await FirebaseAuth.instance.currentUser?.getIdToken())
      return LoginState.successful;
    return LoginState.tokenFailed;
  }
}
