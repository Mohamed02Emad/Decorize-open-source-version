import 'package:dartz/dartz.dart';
import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';

import '../../../../common/failure.dart';
import '../models/responses/auth_response.dart';
import '../params/forget_password_params.dart';
import '../params/login_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(LoginParams params);
  Future<Either<Failure, AuthResponse>> register(RegisterParams params);
  Future<Either<Failure, AuthResponse>> verifyOtp(VerifyOtpParams params);
  Future<Either<Failure, AuthResponse>> forgetPassword(ForgetPasswordParams params);
  Future<Either<Failure, Unit>> resetPassword(ResetPasswordParams params);
}