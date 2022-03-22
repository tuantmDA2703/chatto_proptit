import 'package:flutter/material.dart';

class AppColors {
  //Brand Color
  static const Color brandDefault = Color(0xFF002DE3);
  static const Color light = Color(0xFF879FFF);
  static const Color brandBackGround = Color(0xFFD2D5F9);

  //Neutral Color
  static const Color active = Color(0xFF0F1828);
  static const Color dark = Color(0xFF152033);
  static const Color body = Color(0xFF152033);
  static const Color weak = Color(0xFFA4A4A4);
  static const Color disable = Color(0xFFADB5BD);
  static const Color line = Color(0xFFADB5BD);
  static const Color secondaryBG = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xffF7F7FC);
  static const Color white = Color(0xFFFFFFFF);

  //Accent Color
  static const Color safe = Color(0xFF7BCBCF);
  static const Color success = Color(0xFF2CC069);
  static const Color warning = Color(0xFFFDCF41);
  static const Color danger = Color(0xFFE94242);

  //Gradient
  static const LinearGradient variant01 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFD2D5F9),
      Color(0xFF2C37E1),
    ],
  );
  static const LinearGradient variant02 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFEDA1FF),
      Color(0xFF5F2EEA),
    ],
  );
}
