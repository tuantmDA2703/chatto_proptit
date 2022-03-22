import 'package:chatto_app/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//import '../services/scaffold_messenger_service.dart';

class AppSnackbar {
  // static void showSnackBar(Widget content) {
  //   final snackBar = SnackBar(
  //     content: Center(child: content),
  //   );
  //   print(
  //     //conflict from current context with the BuildContext from widget developer called
  //       GetIt.I<ScaffoldMessengerService>().scaffoldMessengerKey.currentState);
  //   GetIt.I<ScaffoldMessengerService>()
  //       .scaffoldMessengerKey
  //       .currentState?.showSnackBar(snackBar);
  // }
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
     // :))
     // push len choc nua anh xem cho vaang aj em cam own anh nhes 
  showSnackBar(text){
    snackBarKey.currentState?.showSnackBar(
      SnackBar(content: Text(text)),
    );
  }  
}

