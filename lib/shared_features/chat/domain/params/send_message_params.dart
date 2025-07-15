class SendMessageParams {
  final String message;
  final String? conversationId;

  SendMessageParams({required this.conversationId, required this.message});

  toJson() => {
        if (conversationId != null) "chat_id": conversationId,
        "body": message,
      };
}
