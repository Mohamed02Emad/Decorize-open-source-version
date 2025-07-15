class GetMessagesParams {
  final int page;
  final int conversationId;

  GetMessagesParams({required this.page, required this.conversationId});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }
}
