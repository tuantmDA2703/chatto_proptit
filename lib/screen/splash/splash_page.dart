import 'dart:async';
import 'package:chatto_app/base/base_page.dart';
import 'package:chatto_app/base/localizaion.dart';
import 'package:chatto_app/base/utility.dart';
import 'package:chatto_app/config/app_config.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/config/app_string.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Utility utility = Utility();
    Timer(const Duration(seconds: 2), () async {
      utility.navigator.pushed(AppRoute.register);
    });
    return Scaffold(
      body: Center(
        child: Text('Splash ${AppString().str}'),
      ),
    );
  }
}
