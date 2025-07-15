import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/common/fcm/fcm_messaging.dart';
import 'package:decorizer/shared_features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:decorizer/shared_features/auth/domain/models/responses/auth_response.dart';
import 'package:decorizer/shared_features/auth/domain/params/forget_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/login_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';
import 'package:decorizer/shared_features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, AuthResponse>> login(LoginParams params) async =>
      _dataSource
          .login(params.copyWith(
              deviceToken: await FCMMessaging.getToken()))
          .mapError(
        (json) {
          return AuthResponse.fromJson(json['data']);
        },
      );

  @override
  Future<Either<Failure, AuthResponse>> register(RegisterParams params) async =>
      _dataSource
          .register(params.copyWith(
              deviceToken: await FCMMessaging.getToken()))
          .mapError(
        (json) {
          return AuthResponse.fromJson(json['data']);
        },
      );

  @override
  Future<Either<Failure, AuthResponse>> verifyOtp(VerifyOtpParams params) =>
      _dataSource.verifyOtp(params).mapError(
        (json) {
          return AuthResponse.fromJson(json['data']);
        },
      );

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(
          ForgetPasswordParams params) =>
      _dataSource.forgetPassword(params).mapError(
        (json) {
          return AuthResponse.fromJson(json['data']);
        },
      );

  @override
  Future<Either<Failure, Unit>> resetPassword(ResetPasswordParams params) =>
      _dataSource.resetPassword(params).mapError(
            (_) => unit,
          );
}
