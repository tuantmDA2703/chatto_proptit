import 'package:firebase_auth/firebase_auth.dart';

import '../config/app_constant.dart';

abstract class FirebaseRepository {
  Future<User?> getCurrentUser();
  Future<LoginState> checkToken();
  Future<LoginState> authLogin(String email, String password);

  /// check email exits
  Future<bool> checkEmailValid(String email);
  /// authentication for email
  Future<bool> verifyEmail(String email);
  /// sign up account
  Future<bool> signUp(String email, String password);


}
