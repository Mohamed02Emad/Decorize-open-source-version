import '../user.dart';

class AuthResponse {
  final String accessToken;
  final String? verificationCode;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.verificationCode,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    verificationCode: json["verification_code"]?.toString(),
    accessToken: json["access_token"] ?? '',
    user: User.fromJson(json["user"]),
  );

}
