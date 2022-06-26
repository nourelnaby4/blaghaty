import 'package:flutter/material.dart';

import 'app_local.dart';


class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{

  const AppLocalizationDelegate() ;


  @override
  bool isSupported(Locale locale) {
    return ["en" , "ar"].contains(locale.languageCode) ;
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocale = AppLocalization(locale) ;
    await appLocale.load();
    return appLocale ;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
  
}