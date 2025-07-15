import 'package:decorizer/user/orders/domain/models/offer_user.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';

List<ChatModel> chatModelsFromJson(dynamic json) =>
    List<ChatModel>.from(json.map((x) => ChatModel.fromJson(x)));

class ChatModel {
  final int id;
  final OfferUser userOne;
  final OfferUser userTwo;
  final MessageModel? lastMessage;
  final int unreadMessagesCount;

  ChatModel({
    required this.id,
    required this.userOne,
    required this.userTwo,
    this.lastMessage,
    required this.unreadMessagesCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      userOne: OfferUser.fromJson(json['user_one']),
      userTwo: OfferUser.fromJson(json['user_two']),
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'])
          : null,
      unreadMessagesCount: json['unread_messages_count'],
    );
  }

  ChatModel copyWith({
    MessageModel? lastMessage,
    int? unreadMessagesCount,
    OfferUser? userOne,
    OfferUser? userTwo,
    int? id,
  }) {
    return ChatModel(
      id: id ?? this.id,
      userOne: userOne ?? this.userOne,
      userTwo: userTwo ?? this.userTwo,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }
}
