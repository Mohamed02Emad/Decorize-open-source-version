
class ForgetPasswordParams {
  final String email;

  ForgetPasswordParams({required this.email});



  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
