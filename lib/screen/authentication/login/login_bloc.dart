/*
  Create by: Tris1702
  Date: 22/03/2022

  [About this file]
    * This file is Bloc of login screen
    * There are 2 Behaviour subject need handled: loginEnable and loginState
    * loginEnable: - false => not allow to login
                   - true => allow to login (only when email and password fields are filled)
    * loginState: base on LoginState
                  there are 5 state: pending(nothing), loading (waiting for a process),
                                      failed (failed to login), successful (login successfully),
                                        tokenFailed (failed to use token to login)
                                  
*/

import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  @override
  void dispose() {
    loginEnable.close();
    loginState.close();
  }

  @override
  void init() {
    _checkToken();
  }

  final _firebaseRepoImpl = FirebaseRepositoryImpl();

  BehaviorSubject<bool> loginEnable = BehaviorSubject.seeded(false);
  Stream<bool> getLoginEnableStream() => loginEnable.stream;
  Sink<bool> getLoginEnableSink() => loginEnable.sink;

  BehaviorSubject<LoginState> loginState =
      BehaviorSubject.seeded(LoginState.pending);
  Stream<LoginState> getLoginStateStream() => loginState.stream;
  Sink<LoginState> getLoginStateSink() => loginState.sink;

  void checkField(String username, String password) {
    // This function for checking if 2 email and password field are filled
    print(username + ' ' + password);
    if (username.isNotEmpty && password.isNotEmpty) {
      loginEnable.add(true);
    } else {
      loginEnable.add(false);
    }
  }

  void _userLogoutYet() async {
    // This function for checking if user logout yet
  }

  void login(String email, String password) async {
    //This function is for login process
    loginState.add(LoginState.loading);
    loginState.add(await _firebaseRepoImpl.authLogin(email, password));
  }

  void _checkToken() async {
    // This function is for checking token is avaiable
    loginState.add(LoginState.tokenFailed);
  }
}
