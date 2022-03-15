import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  @override
  void dispose() {
    loginEnable.close();
  }

  @override
  void init() {
    checkToken();
  }

  BehaviorSubject<bool> loginEnable = BehaviorSubject.seeded(false);
  Stream<bool> getLoginEnableStream() => loginEnable.stream;
  Sink<bool> getLoginEnableSink() => loginEnable.sink;

  BehaviorSubject<LoginState> loginState =
      BehaviorSubject.seeded(LoginState.pending);
  Stream<LoginState> getLoginStateStream() => loginState.stream;
  Sink<LoginState> getLoginStateSink() => loginState.sink;

  void checkField(String username, String password) {
    print(username + ' ' + password);
    if (username.isNotEmpty && password.isNotEmpty) {
      print('___');
      loginEnable.add(true);
    } else {
      print('++');
      loginEnable.add(false);
    }
  }

  void login(String email, String password) async {
    loginState.add(LoginState.loading);
    await Future.delayed(const Duration(seconds: 2));
    loginState.add(LoginState.successful);
  }

  void checkToken() {
    loginState.add(LoginState.tokenFailed);
  }
}
