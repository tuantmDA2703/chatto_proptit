import 'package:chatto_app/base/set_up_service_locator.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'config/app_route.dart';
import 'screen/splash/splash_page.dart';

void main(){
  setUpServiceLocator();
  runApp(const ChattoApp());
}

class ChattoApp extends StatelessWidget {
  const ChattoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I<NavigatorService>().navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) =>
          AppRoute.getAppPage(routeSettings),
      home: const SplashPage(),
    );
  }
}



