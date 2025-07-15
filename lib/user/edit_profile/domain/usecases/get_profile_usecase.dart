import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/user/edit_profile/domain/params/get_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUsecase extends UseCase<User, GetProfileParams> {
  final EditProfileRepository editProfileRepository;

  GetProfileUsecase({required this.editProfileRepository});

  @override
  Future<Either<Failure, User>> call(GetProfileParams params) async {
    return editProfileRepository.getProfile(params);
  }
}
