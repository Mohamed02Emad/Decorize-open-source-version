import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/user/edit_profile/domain/params/update_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUsecase extends UseCase<User, UpdateProfileParams> {
  final EditProfileRepository editProfileRepository;

  UpdateProfileUsecase({required this.editProfileRepository});

  @override
  Future<Either<Failure, User>> call(UpdateProfileParams params) async {
    return editProfileRepository.updateProfile(params);
  }
}
