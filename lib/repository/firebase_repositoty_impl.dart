// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  var firebaseService = GetIt.I<FirebaseService>();
  var sharedPref = GetIt.I<AppSharedPreference>();

  late FirebaseAuth auth;
  late FirebaseFirestore fireStore;

  static const String authKey = 'Firebase Authentication';
  static const String storageKey = 'Firebase Cloud Storage';

  init() {
    auth = firebaseService.firebaseAuth;
    fireStore = firebaseService.firebaseFireStore;
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

  @override
  Future<String> signUp(String email, String password) async {
    try {
      //create new user in authentication board
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException {
      return AppConstant.fail;
      // error when create user.
      // rethrow;
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

  @override
  Future<void> queryData(String collectionId, String docPath) {
    // TODO: implement queryData
    throw UnimplementedError();
  }

  @override
  Future<void> insertDataWithCustomDocPath(String collectionId, String docPath,
      {dynamic data}) async {
    await fireStore
        .collection(collectionId)
        .doc(docPath)
        .set(data)
        .then((value) {
      //handle successful
      logData(storageKey, 'already added');
    }).catchError((error) {
      //handle error here
      logData(storageKey, 'already added');
    });
  }

  void logData(String key, String message) {
    // ignore: avoid_print
    print('==>$key:$message');
  }
}
