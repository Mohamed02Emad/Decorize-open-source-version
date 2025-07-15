import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/params/forget_password_params.dart';
import 'package:injectable/injectable.dart';

import '../models/responses/auth_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class ForgetPasswordUseCase extends UseCase<AuthResponse, ForgetPasswordParams> {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(ForgetPasswordParams params) async {
    return repository.forgetPassword(params);
  }
}
