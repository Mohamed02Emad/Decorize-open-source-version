import 'package:dio/dio.dart';

import '../../preference/app_preferences.dart';
import '../../preference/item/preference_item.dart';

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String language = getLanguage();

    options.headers['Accept-Language'] = language;

    super.onRequest(options, handler);
  }

  String getLanguage() {
    final lang = PreferenceItem<String>(AppPreferences.language, '').get();
    if (lang.isEmpty) return 'en';
    return lang;
  }
}
