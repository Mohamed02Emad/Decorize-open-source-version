import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';
import 'package:injectable/injectable.dart';

import '../models/responses/auth_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class VerifyOtpUseCase extends UseCase<AuthResponse, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(VerifyOtpParams params) async {
    return repository.verifyOtp(params);
  }
}
