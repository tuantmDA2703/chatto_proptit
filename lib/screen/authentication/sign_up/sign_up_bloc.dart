import 'dart:async';

import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/status.dart';

/*Created by Sudo248

  This is SignUpBloc which manager all state and data of SignUpPage

  
 */

class SignUpBloc extends BlocBase {
  final FirebaseRepository firebaseRepository;

  SignUpBloc({required this.firebaseRepository});

  /// [signUpStatus] hold on status of SignUpPage:
  ///  -> [Idle] : do nothing
  ///  -> [Loading] : request to sign up new user in firebase auth
  ///  -> [Success] : sign up success
  ///  -> [Error] : error when loading.

  BehaviorSubject<Status<String>> signUpStatus = BehaviorSubject.seeded(Idle());
  Stream<Status<String>> get signUpStatusStream => signUpStatus.stream;
  Sink<Status<String>> get signUpStatusSink => signUpStatus.sink;

  /// [email] hold on status of email field
  ///  -> [Idle] : show a email TextField
  ///  -> [Loading] : show a CircularProgressIndicator while [checkEmailValid]
  ///  -> [Success] : show a tick icon if email is vaild
  ///  -> [Error] : show a x icon if [isEmail] fasle

  BehaviorSubject<Status> email = BehaviorSubject.seeded(Idle());
  Stream<Status> get emailStream => email.stream;
  Sink<Status> get emailSink => email.sink;

  /// [password] hold on status of password field
  ///  -> [Idle] : show a password TextField
  ///  -> [Success] : show a tick icon if [isPassWord] true
  ///  -> [Error] : show a x icon if [isPassWord] false

  BehaviorSubject<Status> password = BehaviorSubject.seeded(Idle());
  Stream<Status> get passwordStream => password.stream;
  Sink<Status> get passwordSink => password.sink;

  /// [confirmPassword] hold on status of confirm password field
  ///  -> [Idle] : show a confirm password TextField
  ///  -> [Success] : show a tick icon if confirmPassword == [passwordValue]
  ///  -> [Error] : show a x icon if if confirmPassword != [passwordValue]

  BehaviorSubject<Status> confirmPassword = BehaviorSubject.seeded(Idle());
  Stream<Status> get confirmPasswordStream => confirmPassword.stream;
  Sink<Status> get confirmPasswordSink => confirmPassword.sink;

  /// [signUpValid] hold on status of sign up button
  /// sign up button availble if true else null
  ///
  Stream<bool> get signUpValid =>
      Rx.combineLatest3<Status, Status, Status, bool>(
          emailStream, passwordStream, confirmPasswordStream, (e, p, c) {
        return (e is Success) && (p is Success) && (c is Success);
      });

  String emailValue = "";
  String passwordValue = "";
  String confirmPasswordValue = "";

  /// schedule time 500 ms for each check email
  ///
  Timer? timer;

  @override
  void init() {
    logData("onInit SignUpBloc", "success");
  }

  void onSignUpClick() async {
    try {
      signUpStatusSink.add(Loading());

      await firebaseRepository.signUp(emailValue, passwordValue);

      signUpStatusSink.add(Success(data: "Success"));

      navigator.pushed(AppRoute.login);
    } on FirebaseAuthException catch (e) {
      signUpStatusSink.add(Error(message: e.toString()));
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
      emailSink.add(Loading());
      if (!await firebaseRepository.checkEmailValid(email)) {
        emailSink.add(Success(data: true));
      } else {
        emailSink.add(Error(message: "This email already sign up."));
      }
    } else {
      emailSink.add(Error(message: "Invalid email"));
    }
  }

  void verifyPassword(String password) async {
    if (isPassWord(password)) {
      passwordValue = password;
      passwordSink.add(Success(data: true));
    } else {
      passwordSink.add(Error(message: "Must more than 8 character"));
    }
  }

  void verifyConfirmPassword(String confirmPassword) async {
    if (passwordValue.isEmpty) {
      confirmPasswordSink.add(Error(message: "Must correct password"));
    } else if (confirmPassword == passwordValue) {
      confirmPasswordSink.add(Success(data: true));
    } else {
      confirmPasswordSink.add(Error(message: "Must like password"));
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
