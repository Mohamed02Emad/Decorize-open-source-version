import 'dart:io';

import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/shared_features/logout_stream.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/preference/app_preferences.dart';
import '../data/remote/interceptor/language_interceptor.dart';
import '../data/remote/interceptor/token_interceptor.dart';

//todo :  make sure 401 doesnot change lang or theme

@Singleton()
class ApiBaseHelper {
   late String _baseUrl;
  final Dio dio = Dio();

  ApiBaseHelper() {
    //todo : add base url here
    _baseUrl = 'put yours here';
    _initDio();
    _initInterceptors();
  }

  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    _initDio();
  }

  void _initDio() {
    dio.options = BaseOptions(
      baseUrl: _baseUrl,
      headers: _defaultHeaders,
      validateStatus: (_) => true,
      sendTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );
  }

  void _initInterceptors() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      enabled: kDebugMode,
    ));
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(LanguageInterceptor());
  }


  final Map<String, String> _defaultHeaders = {
    'Accept': 'application/json',
    'Accept-Language': 'ar',
    'Content-Type': 'application/json',
  };

  DatasourceResult get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _handleRequest(() => dio.get(url, queryParameters: queryParameters));
  }

  DatasourceResult put({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return _handleRequest(() => dio.put(url, data: body));
  }

  DatasourceResult post({
    required String url,
    String? baseUrl,
    Map<String, dynamic>? body,
    FormData? form,
    Map<String, dynamic>? queryParams,
  }) async {
    final formData = form ?? FormData.fromMap(body ?? {});
    final isMultipart = form?.files.isNotEmpty == true;

    String? originalBaseUrl;
    final originalHeaders = Map<String, String>.from(dio.options.headers);

    if (baseUrl != null) {
      originalBaseUrl = dio.options.baseUrl;
      dio.options.baseUrl = baseUrl;
    }

    if (isMultipart) {
      dio.options.headers.remove('Content-Type');
    }

    try {
      return await _handleRequest(
          () => dio.post(url, data: formData, queryParameters: queryParams));
    } finally {
      if (originalBaseUrl != null) {
        dio.options.baseUrl = originalBaseUrl;
      }
      dio.options.headers = originalHeaders;
    }
  }

  DatasourceResult postWithRaw({
    required String url,
    String? baseUrl,
    required Map<String, dynamic> body,
  }) async {
    String? originalBaseUrl;

    if (baseUrl != null) {
      originalBaseUrl = dio.options.baseUrl;
      dio.options.baseUrl = baseUrl;
    }

    try {
      return await _handleRequest(() => dio.post(url, data: body));
    } finally {
      if (originalBaseUrl != null) {
        dio.options.baseUrl = originalBaseUrl;
      }
    }
  }

  DatasourceResult postWithImage({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    _setCustomTimeouts(
      const Duration(milliseconds: 30000),
    );
    final formData = FormData.fromMap(body);
    final response = await _handleRequest(() => dio.post(url, data: formData));
    _resetTimeouts();
    return response;
  }

  DatasourceResult delete({
    required String url,
  }) async {
    return _handleRequest(() => dio.delete(url));
  }

  DatasourceResult uploadImage(
      {required String url, required File file}) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return _handleRequest(() => dio.post(url, data: formData));
  }

  Future<Response> _handleRequest(Future<Response> Function() request) async {
    try {
      final Response response = await request();
      return _returnResponse(response);
    } on DioException catch (e) {
      return _returnResponse(e.response);
    } on UnAuthorizedException catch (_) {
      throw ServerException(LocaleKeys.error_error_happened);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (_) {
      throw ServerException(LocaleKeys.error_error_happened);
    }
  }

  Response _returnResponse(Response? response) {
    if (response == null) {
      throw ServerException(LocaleKeys.error_error_happened);
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400 || 422 || 403:
        throw ServerException(response.data['message']?.toString() ?? '');
      case 401:
        _handleUnauthorized(response.data['message']?.toString());
        throw UnAuthorizedException(response.data['message']?.toString() ?? '');
      case 500:
      default:
        throw ServerException(LocaleKeys.error_server_error.tr());
    }
  }

  void _handleUnauthorized(String? message) {
    AppPreferences.clear();
    logoutStream.addData(message ?? '');
  }

  void _setCustomTimeouts(Duration timeout) {
    dio.options.sendTimeout = timeout;
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
  }

  void _resetTimeouts() {
    _setCustomTimeouts(const Duration(milliseconds: 8000));
  }
}

class BaseException implements Exception {
  final String? message;

  BaseException(this.message);

  @override
  String toString() => message ?? 'An error occurred.';
}

class ServerException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;

  ServerException(
    this.message, {
    this.errorMap,
  });
}

class UnAuthorizedException extends BaseException {
  UnAuthorizedException(String super.message);
}
