import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/user/edit_profile/domain/params/change_password_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/get_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/update_profile_params.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, User>> updateProfile(UpdateProfileParams params);
  Future<Either<Failure, User>> getProfile(GetProfileParams params);
  Future<Either<Failure, Unit>> changePassword(ChangePasswordParams params);
}
