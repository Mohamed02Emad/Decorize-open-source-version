import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';
import '../common.dart';

enum Language {
  // korean(Locale('ko'), '$basePath/flag/flag_kr.png'),
  arabic(Locale('ar'), AppSvgs.qatar),
  english(Locale('en'), AppSvgs.usa);

  final Locale locale;
  final String flagPath;

  const Language(this.locale, this.flagPath);

  static Language find(String key) {
    return Language.values.asNameMap()[key] ?? Language.arabic;
  }
}

Language get currentLanguage =>
    App.navigatorKey.currentContext?.locale.languageCode == 'ar'
        ? Language.arabic
        : Language.english;

bool isArabic() => currentLanguage == Language.arabic;
