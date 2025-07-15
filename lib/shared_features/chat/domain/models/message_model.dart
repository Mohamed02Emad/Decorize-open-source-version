
import 'package:decorizer/shared_features/chat/domain/enums/message_status.dart';
import 'package:decorizer/user/orders/domain/models/offer_user.dart';
import 'package:equatable/equatable.dart';

List<MessageModel> messageModelFromJson(dynamic json) =>
    List<MessageModel>.from(json.map((x) => MessageModel.fromJson(x)));

class MessageModel extends Equatable {
  final int? id;
  final String? message;
  final int? chatId;
  final OfferUser? user;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final MessageStatus? status;
  final String? localId;

  const MessageModel({
    this.id,
    this.message,
    this.chatId,
    this.user,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.localId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["body"],
        chatId: json["chat_id"],
        user: json["sender"] != null ? OfferUser.fromJson(json["sender"]) : null,
        isRead: json["is_read"] == 1 || json["is_read"] == true,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  @override
  List<Object?> get props => [
        message,
        createdAt,
        id,
        chatId,
        user,
        isRead,
        createdAt,
        updatedAt,
        status,
        localId,
      ];

  MessageModel copyWith({
    int? id,
    String? message,
    int? chatId,
    OfferUser? user,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageStatus? status,
    String? localId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      chatId: chatId ?? this.chatId,
      user: user ?? this.user,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      localId: localId ?? this.localId,
    );
  }

  factory MessageModel.local(String message, String localId, int chatId , OfferUser user) => MessageModel(
        message: message,
        localId: localId,
        status: MessageStatus.sending,
        chatId: chatId,
        user: user,
      );

  int? get senderId => user?.id;

}
