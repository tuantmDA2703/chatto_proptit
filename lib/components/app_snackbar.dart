import 'package:chatto_app/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/scaffold_messenger_service.dart';

class AppSnackbar {
  static void showSnackBar(Widget content) {
    final snackBar = SnackBar(
      content: Center(child: content),
    );
    GetIt.I<ScaffoldMessengerService>()
        .scaffoldMessengerKey
        .currentState!
        .showSnackBar(snackBar);
  }
}
