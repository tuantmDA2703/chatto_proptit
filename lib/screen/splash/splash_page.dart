import 'dart:async';
import 'package:chatto_app/base/utility.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//import '../../services/scaffold_messenger_service.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utility utility = Utility();
    Timer(const Duration(seconds: 2), () async {
     utility.navigator.pushed(AppRoute.login);
    });
    return Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
