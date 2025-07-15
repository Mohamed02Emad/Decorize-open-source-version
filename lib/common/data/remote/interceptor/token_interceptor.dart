import 'package:dio/dio.dart';

import '../../preference/app_preferences.dart';
import '../../preference/item/preference_item.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = getUserAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppPreferences.clear();
    }
    super.onError(err, handler);
  }

  String? getUserAccessToken() {
    final token = PreferenceItem<String>(AppPreferences.accessToken, '').get();
    if (token.isEmpty) return null;
    return token;
  }
}
