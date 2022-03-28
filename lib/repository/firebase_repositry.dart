import 'package:firebase_auth/firebase_auth.dart';

import '../config/app_constant.dart';

abstract class FirebaseRepository {
  //firebase authentication
  //verify email, verify email, sign up account in authentication dashboard
  //simple authentication:login, sign up
  Future<bool> checkEmailValid(String email);
  Future<bool> verifyEmail(String email);
  Future<String> signUp(String email, String password);
  Future<User?> getCurrentUser();
  Future<LoginState> checkToken();
  Future<LoginState> authLogin(String email, String password);

  //firebase storage
  //insert data to cloud fire store and read data once
  Future<void> insertDataWithCustomDocPath(String collectionId,String docPath,{dynamic data});
  Future<void> queryData(String collectionId,String docPath);
}
