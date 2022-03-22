import 'package:flutter/material.dart';

/*
  Create by: Tris1702
  Date: 22/03/2022

  [About this file]
    * This file supply snack bar for entire app, to use it
      call GetIt.I<AppSnackBar>().showSnackBar(text)
      with text is a String and it will show a snack bar which
      has content is the text you added in
*/

class AppSnackbar {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
  showSnackBar(text){
    snackBarKey.currentState?.showSnackBar(
      SnackBar(content: Text(text)),
    );
  }  
}

