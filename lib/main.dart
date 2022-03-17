import 'package:chatto_app/base/localizaion.dart';
import 'package:chatto_app/base/set_up_service_locator.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'config/app_route.dart';
import 'screen/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  GetIt.I<AppSharedPreference>().getAppSharedPreference();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(Localization.getLocalizationApp(app: const ChattoApp()));
}

class ChattoApp extends StatelessWidget {
  const ChattoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: GetIt.I<NavigatorService>().navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) =>
          AppRoute.getAppPage(routeSettings),
      home: const SplashPage(),
    );
  }
}
