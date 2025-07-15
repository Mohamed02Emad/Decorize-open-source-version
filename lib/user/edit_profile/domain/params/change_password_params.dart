class ChangePasswordParams {
  final String oldPassword;
  final String password;
  final String confirmPassword;

  ChangePasswordParams({
    required this.oldPassword,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }
}
