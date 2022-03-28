import 'dart:async';

import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/status.dart';

/*Created by Sudo248

  This is SignUpBloc which manager all state and data of SignUpPage

  
 */

class SignUpBloc extends BlocBase {
  /// setter injection
  final FirebaseRepository firebaseRepository =
      GetIt.I.get<FirebaseRepositoryImpl>();

  /// [signUpStatus] hold on status of SignUpPage:
  ///  -> [pending] : do nothing
  ///  -> [loading] : request to sign up new user in firebase auth
  ///  -> [success] : sign up success
  ///  -> [error] : error when loading.

  BehaviorSubject<AppState> signUpStatus =
      BehaviorSubject.seeded(AppState.pending);
  Stream<AppState> get signUpStatusStream => signUpStatus.stream;
  Sink<AppState> get signUpStatusSink => signUpStatus.sink;

  /// [email] hold on status of email field
  ///  -> [Idle] : show a email TextField
  ///  -> [Loading] : show a CircularProgressIndicator while [checkEmailValid]
  ///  -> [Success] : show a tick icon if email is vaild
  ///  -> [Error] : show a x icon if [isEmail] fasle

  BehaviorSubject<AppState> email = BehaviorSubject.seeded(AppState.pending);
  Stream<AppState> get emailStream => email.stream;
  Sink<AppState> get emailSink => email.sink;

  /// [password] hold on status of password field
  ///  -> [Idle] : show a password TextField
  ///  -> [Success] : show a tick icon if [isPassWord] true
  ///  -> [Error] : show a x icon if [isPassWord] false

  BehaviorSubject<AppState> password = BehaviorSubject.seeded(AppState.pending);
  Stream<AppState> get passwordStream => password.stream;
  Sink<AppState> get passwordSink => password.sink;

  /// [confirmPassword] hold on status of confirm password field
  ///  -> [Idle] : show a confirm password TextField
  ///  -> [Success] : show a tick icon if confirmPassword == [passwordValue]
  ///  -> [Error] : show a x icon if if confirmPassword != [passwordValue]

  BehaviorSubject<AppState> confirmPassword =
      BehaviorSubject.seeded(AppState.pending);
  Stream<AppState> get confirmPasswordStream => confirmPassword.stream;
  Sink<AppState> get confirmPasswordSink => confirmPassword.sink;

  /// [signUpValid] hold on status of sign up button
  /// sign up button availble if true else null
  ///
  Stream<bool> get signUpValid =>
      Rx.combineLatest3<AppState, AppState, AppState, bool>(
          emailStream, passwordStream, confirmPasswordStream, (e, p, c) {
        return (e == AppState.successful) &&
            (p == AppState.successful) &&
            (c == AppState.successful);
      });

  String emailValue = "";
  String passwordValue = "";
  String confirmPasswordValue = "";

  String? errorSignUp;
  String? errorEmail;
  String? errorPassword;
  String? errorConfirmPassword;

  /// schedule time 500 ms for each check email
  ///
  Timer? timer;

  @override
  void init() {
    logData("onInit SignUpBloc", "success");
  }

  void onSignUpClick() async {
    try {
      signUpStatusSink.add(AppState.loading);

      await firebaseRepository.signUp(emailValue, passwordValue);

      signUpStatusSink.add(AppState.successful);

      navigator.pushed(AppRoute.login);
    } on FirebaseAuthException catch (e) {
      errorSignUp = e.toString();
      signUpStatusSink.add(AppState.failed);
    }
  }

  void deboundTimeVerifyEmail(String email,
      [Duration duration = const Duration(milliseconds: 500)]) async {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(duration, () => verifyEmail(email));
  }

  void verifyEmail(String email) async {
    if (isEmail(email)) {
      emailValue = email;
      emailSink.add(AppState.loading);
      if (!await firebaseRepository.checkEmailValid(email)) {
        emailSink.add(AppState.successful);
      } else {
        errorEmail = "This email already sign up";
        emailSink.add(AppState.failed);
      }
    } else {
      errorEmail = "Invalid email";
      emailSink.add(AppState.failed);
    }
  }

  void verifyPassword(String password) async {
    if (isPassWord(password)) {
      passwordValue = password;
      passwordSink.add(AppState.successful);
    } else {
      errorPassword = "Must more than 8 character";
      passwordSink.add(AppState.failed);
    }
  }

  void verifyConfirmPassword(String confirmPassword) async {
    if (passwordValue.isEmpty) {
      errorConfirmPassword = "Must correct password";
      confirmPasswordSink.add(AppState.failed);
    } else if (confirmPassword == passwordValue) {
      confirmPasswordSink.add(AppState.successful);
    } else {
		errorConfirmPassword = "Must like password";
      confirmPasswordSink.add(AppState.failed);
    }
  }

  bool isEmail(String email) {
    String value =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(value);

    return regExp.hasMatch(email);
  }

  bool isPassWord(String password) {
    return password.length > 8;
  }

  @override
  void dispose() {
    timer?.cancel();
    signUpStatus.close();
    email.close();
    password.close();
    confirmPassword.close();
  }
}
