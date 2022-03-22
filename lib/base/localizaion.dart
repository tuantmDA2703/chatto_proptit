//import 'package:chatto_app/components/restart_widget.dart';
import 'package:chatto_app/config/app_config.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Localization {
  static const List<Locale> supportedLanguage = [Locale('en'), Locale('vi')];
  static const Locale defaultLanguage = Locale('vi');
  static const String languageFilePath = 'assets/translation';

  static Widget getLocalizationApp({app}) {
    var pref = GetIt.I<AppSharedPreference>();
    String appLang = pref.getString(AppConfig.appLangCode, defaultValue: 'vi');
    return EasyLocalization(
        supportedLocales: supportedLanguage,
        path: languageFilePath,
        startLocale: Locale(appLang),
        fallbackLocale: defaultLanguage,
        child: app);
  }

  static changeLanguage(BuildContext context) {
    var pref = GetIt.I<AppSharedPreference>();
    String currentLangCode =  pref.getString(AppConfig.appLangCode);
    if(currentLangCode == 'vi'){
      context.setLocale(supportedLanguage[0]);
      pref.saveString(AppConfig.appLangCode, 'en');
    }else{
      context.setLocale(supportedLanguage[1]);
      pref.saveString(AppConfig.appLangCode, 'vi');
    }
  }

}
