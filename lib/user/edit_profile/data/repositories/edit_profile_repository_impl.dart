import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/setters/set_cached_user_usecase.dart';
import 'package:decorizer/user/edit_profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:decorizer/user/edit_profile/domain/params/change_password_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/get_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/update_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl extends EditProfileRepository {
  final EditProfileRemoteDatasource remoteDatasource;
  final SetCachedUserUseCase setCachedUserUseCase;

  EditProfileRepositoryImpl({
    required this.remoteDatasource,
    required this.setCachedUserUseCase,
  });

  @override
  Future<Either<Failure, User>> updateProfile(UpdateProfileParams params) {
    return remoteDatasource.updateProfile(params).mapError((json) {
      final user = User.fromJson(json['data']['user']);
      _updateCachedUser(user);
      return user;
    });
  }

  @override
  Future<Either<Failure, User>> getProfile(GetProfileParams params) {
    return remoteDatasource.getProfile(params).mapError((json) {
      final user = User.fromJson(json['data']['user']);
      _updateCachedUser(user);
      return user;
    });
  }

  @override
  Future<Either<Failure, Unit>> changePassword(ChangePasswordParams params) {
    return remoteDatasource.changePassword(params).mapError((json) {
      return unit;
    });
  }

  void _updateCachedUser(User user) {
    setCachedUserUseCase(user);
  }
}
