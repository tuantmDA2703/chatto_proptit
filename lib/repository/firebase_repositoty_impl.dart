// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class FirebaseRepositoryImpl extends FirebaseRepository{
  var firebaseService = GetIt.I<FirebaseService>();
  late FirebaseAuth auth;
  init(){
    auth = firebaseService.firebaseAuth;
  }

  @override
  Future<User?> getCurrentUser() async{
    return FirebaseAuth.instance.currentUser;
  }
}