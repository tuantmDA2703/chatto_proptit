import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  Future<User?> getCurrentUser();

  /// check email exits
  Future<bool> checkEmailValid(String email);
  /// authen for email
  Future<bool> verifyEmail(String email);
  /// sign up account
  Future<bool> signUp(String email, String password);

  
}
