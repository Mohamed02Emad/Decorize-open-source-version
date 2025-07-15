class VerifyOtpParams{
  final String code;
  final String? email;

  VerifyOtpParams({required this.code, required this.email});

  Map<String, dynamic> toJson() => {
    'code': code,
    'email': email,
  };
}