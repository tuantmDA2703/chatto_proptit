import 'package:flutter/material.dart';

class AppSnackbar {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
  showSnackBar(text){
    snackBarKey.currentState?.showSnackBar(
      SnackBar(content: Text(text)),
    );
  }  
}

