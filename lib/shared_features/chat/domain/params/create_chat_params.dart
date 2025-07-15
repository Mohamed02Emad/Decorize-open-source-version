class CreateChatParams {
  final String userId;

  CreateChatParams({required this.userId});

  Map<String, dynamic> toJson() => {'user_id': userId};
}
