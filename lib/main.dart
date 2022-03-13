import 'package:chatto_app/base/set_up_service_locator.dart';
import 'package:flutter/material.dart';
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
      home: SplashPage(),
    );
  }
}



