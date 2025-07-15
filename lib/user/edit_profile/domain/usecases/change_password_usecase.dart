import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/edit_profile/domain/params/change_password_params.dart';
import 'package:decorizer/user/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ChangePasswordUseCase extends UseCase<Unit, ChangePasswordParams> {
  final EditProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ChangePasswordParams params) {
    return repository.changePassword(params);
  }
}
