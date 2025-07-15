class LoginParams{
  final String email , password;
  String? deviceToken;

  LoginParams({required this.email, required this.password});

  LoginParams copyWith({
    String? email,
    String? password,
    String? deviceToken,
  }) {
    return LoginParams(
      email: email ?? this.email,
      password: password ?? this.password,
    )..deviceToken = deviceToken ?? this.deviceToken;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    if(deviceToken != null) {
      data['device_token'] = deviceToken;
    }
    return data;
  }
}
