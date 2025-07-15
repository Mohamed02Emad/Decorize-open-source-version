part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final RequestState<Unit> changePasswordState;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool hasChanges;

  ChangePasswordState.initial()
      : changePasswordState = RequestState.initial(),
        oldPassword = '',
        newPassword = '',
        confirmPassword = '',
        hasChanges = false;

  const ChangePasswordState({
    required this.changePasswordState,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.hasChanges,
  });

  ChangePasswordState copyWith({
    RequestState<Unit>? changePasswordState,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? hasChanges,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }

  bool get isFormValid {
    return oldPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        newPassword == confirmPassword &&
        newPassword.length >= 6;
  }

  String? get passwordError {
    if (newPassword.isEmpty) return null;
    if (newPassword.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? get confirmPasswordError {
    if (confirmPassword.isEmpty) return null;
    if (newPassword != confirmPassword) return 'Passwords do not match';
    return null;
  }

  @override
  List<Object?> get props => [
        changePasswordState,
        oldPassword,
        newPassword,
        confirmPassword,
        hasChanges,
      ];
}
