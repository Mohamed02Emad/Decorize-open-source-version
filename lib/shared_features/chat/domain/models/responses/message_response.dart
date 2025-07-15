
import '../message_model.dart';

class MessageResponse {
  final List<MessageModel> messages;

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      messages: List<MessageModel>.from(
        json['data'].map(
          (x) => MessageModel.fromJson(x),
        ),
      ),
    );
  }

  MessageResponse({required this.messages});
}
