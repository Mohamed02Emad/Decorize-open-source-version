import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/user/edit_profile/domain/params/change_password_params.dart';
import 'package:decorizer/user/edit_profile/domain/usecases/change_password_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_state.dart';

@Injectable()
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(this.changePasswordUseCase)
      : super(ChangePasswordState.initial());

  void updateOldPassword(String value) {
    emit(state.copyWith(
      oldPassword: value,
      hasChanges: _hasChanges(oldPassword: value),
    ));
  }

  void updateNewPassword(String value) {
    emit(state.copyWith(
      newPassword: value,
      hasChanges: _hasChanges(newPassword: value),
    ));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(
      confirmPassword: value,
      hasChanges: _hasChanges(confirmPassword: value),
    ));
  }

  bool _hasChanges({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    final currentOldPassword = oldPassword ?? state.oldPassword;
    final currentNewPassword = newPassword ?? state.newPassword;
    final currentConfirmPassword = confirmPassword ?? state.confirmPassword;

    return currentOldPassword.isNotEmpty ||
        currentNewPassword.isNotEmpty ||
        currentConfirmPassword.isNotEmpty;
  }

  Future<void> changePassword() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(changePasswordState: RequestState.loading()));

    final params = ChangePasswordParams(
      oldPassword: state.oldPassword,
      password: state.newPassword,
      confirmPassword: state.confirmPassword,
    );

    final result = await changePasswordUseCase(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          changePasswordState: RequestState.error(failure.message),
        ));
        showErrorToast(failure.message);
      },
      (success) {
        emit(state.copyWith(
          changePasswordState: RequestState.success(success),
          oldPassword: '',
          newPassword: '',
          confirmPassword: '',
          hasChanges: false,
        ));
        showSuccessToast('Password changed successfully');
      },
    );
  }
}
