
class ResetPasswordParams {
  final String password;

  ResetPasswordParams({required this.password});



  Map<String, dynamic> toJson() => {
        'password': password,
        'password_confirmation': password,
      };
}
