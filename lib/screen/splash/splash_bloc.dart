import 'dart:async';
import 'package:chatto_app/base/bloc_base.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:get_it/get_it.dart';

class SplashBloc extends BlocBase {
  @override
  void dispose() {

  }

  @override
  void init() {
    GetIt.I<FirebaseRepositoryImpl>().init();
    Timer(
      const Duration(seconds: 2),
      () => navigator.popAndPush(AppRoute.login),
    );
  }
}
