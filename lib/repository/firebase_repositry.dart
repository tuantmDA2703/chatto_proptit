import 'package:firebase_auth/firebase_auth.dart';

import '../config/app_constant.dart';

abstract class FirebaseRepository {
  Future<User?> getCurrentUser();
  Future<LoginState> checkToken();
  Future<LoginState> authLogoutYet();
  Future<LoginState> authLogin(String email, String password);
}
