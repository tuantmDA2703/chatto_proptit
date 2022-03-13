import 'package:chatto_app/screen/authentication/login/login_page.dart';
import 'package:chatto_app/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';

/// Declare constant string route here
/// Then create app page with routeSettings name

class AppRoute {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';

  static Route<dynamic> getAppPage(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        );
    }
  }
}
