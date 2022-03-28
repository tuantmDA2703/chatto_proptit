import 'dart:async';

import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_config.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:chatto_app/repository/firebase_repositry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/status.dart';

class SignUpBloc extends BlocBase {
  /// setter injection
  final FirebaseRepository firebaseRepository =
      GetIt.I.get<FirebaseRepositoryImpl>();

  BehaviorSubject<Status<String>> signUpStatus = BehaviorSubject.seeded(Idle());

  Stream<Status<String>> get signUpStatusStream => signUpStatus.stream;

  Sink<Status<String>> get signUpStatusSink => signUpStatus.sink;

  BehaviorSubject<Status> email = BehaviorSubject.seeded(Idle());

  Stream<Status> get emailStream => email.stream;

  Sink<Status> get emailSink => email.sink;

  BehaviorSubject<Status> password = BehaviorSubject.seeded(Idle());

  Stream<Status> get passwordStream => password.stream;

  Sink<Status> get passwordSink => password.sink;

  BehaviorSubject<Status> confirmPassword = BehaviorSubject.seeded(Idle());

  Stream<Status> get confirmPasswordStream => confirmPassword.stream;

  Sink<Status> get confirmPasswordSink => confirmPassword.sink;

  Stream<bool> get signUpValid =>
      Rx.combineLatest3<Status, Status, Status, bool>(
          emailStream, passwordStream, confirmPasswordStream, (e, p, c) {
        return (e is Success) && (p is Success) && (c is Success);
      });

  String emailValue = "";
  String passwordValue = "";
  String confirmPasswordValue = "";

  Timer? timer;

  @override
  void init() {
    logData("onInit SignUpBloc", "success");
  }

  void onSignUpClick() async {
    try {
      signUpStatusSink.add(Loading());
      String response =
          await firebaseRepository.signUp(emailValue, passwordValue);
      signUpStatusSink.add(Success(data: "Success"));
      if (response == AppConstant.fail) {
        //handle error from authentication board error
      } else {
        //sign up successfully then insert user into cloud fire store
        var data = {
          'aboutMe': "",
          'avatarUrl': AppConstant.defaultAvatarUrl,
          'fullName': ""
        };
        firebaseRepository.insertDataWithCustomDocPath(
          AppConfig.users,
          response,
          data: data,
        );
        navigator.pushed(AppRoute.login);
      }
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
