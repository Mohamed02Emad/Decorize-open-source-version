import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';

import '../../failure.dart';
import '../../util/api_basehelper.dart';

typedef DatasourceResult = Future<Response>;

extension ResponseExtentions on DatasourceResult {
  Future<Either<Failure, T>> mapError<T>(
    T Function(Map<String, dynamic> json) converter, {
    Function(T data)? onSuccess,
  }) async {
    try {
      final Response result = await this;
      final data = converter(result.data);
      if (result.statusCode == 200 && onSuccess != null) {
        await onSuccess(data);
      }
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: LocaleKeys.error_server_error.tr()));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.error_error_happened.tr()));
    }
  }
}
