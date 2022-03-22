//import 'package:chatto_app/components/restart_widget.dart';
import 'package:chatto_app/config/app_config.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/*
  Create by: TuanTm2703
  Date: 22/03/2022

  [About this file]
    *Base localization file with supported language english and vietnamese
    *change locale in this function but need time to test more cases
    *is it really necessary to call in stateful widget?
*/

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
