import 'package:chatto_app/base/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/status.dart';

class SignUpBloc extends BlocBase {
  BehaviorSubject<Status<String>> signUpStatus = BehaviorSubject.seeded(Idle());
  Stream<Status<String>> get signUpStatusStream => signUpStatus.stream;
  Sink<Status<String>> get signUpStatusSink => signUpStatus.sink;

  @override
  void init() {
    // TODO: implement init
  }

  void onSignUpClick(
      String userName, String password, String confirmPassword) async {
    signUpStatusSink.add(Loading());
    await Future.delayed(const Duration(seconds: 1));
    signUpStatusSink.add(Error(message: "Wrong password"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
