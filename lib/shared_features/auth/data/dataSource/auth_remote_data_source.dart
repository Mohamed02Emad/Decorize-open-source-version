import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/data/remote/datasource_result.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/forget_password_params.dart';
import '../../domain/params/login_params.dart';
import '../auth_end_points.dart';

abstract class AuthRemoteDataSource {
  DatasourceResult login(LoginParams params);
  DatasourceResult register(RegisterParams params);
  DatasourceResult verifyOtp(VerifyOtpParams params);
  DatasourceResult forgetPassword(ForgetPasswordParams params);
  DatasourceResult resetPassword(ResetPasswordParams params);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiBaseHelper helper;

  AuthRemoteDataSourceImpl(this.helper);

  @override
  DatasourceResult login(LoginParams params) {
    return helper.post(
      url: AuthEndPoints.login,
      body: params.toJson()
    );
  }

  @override
  DatasourceResult register(RegisterParams params) {
    return helper.post(
      url: AuthEndPoints.register,
      body: params.toJson()
    );
  }

  @override
  DatasourceResult verifyOtp(VerifyOtpParams params) {
    return helper.post(
      url: AuthEndPoints.verifyOtp,
      body: params.toJson()
    );
  }

  @override
  DatasourceResult forgetPassword(ForgetPasswordParams params) {
    return helper.post(
      url: AuthEndPoints.forgetPassword,
      body: params.toJson()
    );
  }

  @override
  DatasourceResult resetPassword(ResetPasswordParams params) {
    return helper.post(
      url: AuthEndPoints.resetPassword,
      body: params.toJson()
    );
  }
}
