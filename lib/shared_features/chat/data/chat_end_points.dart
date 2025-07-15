class ChatEndPoints {
  ChatEndPoints._();
  static final String createChat = '/auth/chats/create';
  static final String chats = '/auth/chats';
  static String messages(int conversationId) =>
      '/auth/chats/get-messages/$conversationId';
  static final String sendMessage = '/auth/chats/send-message';
  static final String getUnreadMessageCount =
      '/auth/chats/un-read-message-count';
}
