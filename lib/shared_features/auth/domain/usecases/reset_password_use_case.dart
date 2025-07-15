import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@Injectable()
class ResetPasswordUseCase extends UseCase<Unit, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ResetPasswordParams params) async {
    return repository.resetPassword(params);
  }
}
