import 'dart:io';

import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/user/edit_profile/domain/params/update_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/usecases/update_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'update_profile_state.dart';

@injectable
class UpdateProfileCubit extends BaseCubit<UpdateProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;

  UpdateProfileCubit(this.updateProfileUsecase)
      : super(UpdateProfileState.initial());

  void initializeFields(User user) {
    emit(state.copyWith(
      name: user.name,
      email: user.email,
      phone: user.phone,
      password: '**********',
      profileImageUrl: user.image,
      isInitialized: true,
      originalName: user.name,
      originalEmail: user.email,
      originalPhone: user.phone,
      originalProfileImageUrl: user.image,
    ));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateProfileImage(File? image) {
    emit(state.copyWith(
      profileImage: image,
      profileImageUrl: image != null ? null : state.profileImageUrl,
    ));
  }

  Future<void> saveProfile() async {
    final params = UpdateProfileParams(
      name: state.name,
      email: state.email,
      phone: state.phone,
      password: state.password == '**********' ? null : state.password,
      profileImage: state.profileImage,
    );

    await updateProfile(params);
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    callAndFold(
      future: updateProfileUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(updateProfileState: requestState)),
      error: (error) {
        emit(state.copyWith(updateProfileState: RequestState.error(error)));
      },
      success: (user) {
        emit(state.copyWith(updateProfileState: RequestState.success(user)));
      },
    );
  }
}
