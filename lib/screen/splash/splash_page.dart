import 'dart:async';
import 'package:chatto_app/base/utility.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/config/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Utility utility = Utility();
    Timer(
      const Duration(seconds: 2),
      () => utility.navigator.popAndPush(AppRoute.register),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/ic_splash.svg'),
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      AppString.welcomeTitle,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            //Welcome title
          ],
        ),
      ),
    );
  }
}
