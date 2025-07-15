import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/params/create_chat_params.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_chats_params.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_messages_params.dart';

import '../params/send_message_params.dart';

abstract class ChatRepository {
  Future<Either<Failure, MessageModel>> sendMessage(SendMessageParams params);

  Future<Either<Failure, List<MessageModel>>> getMessages(
      GetMessagesParams params);

  Future<Either<Failure, List<ChatModel>>> getChats(GetChatsParams params);

  Future<Either<Failure, ChatModel>> createChat(CreateChatParams params);

  Future<Either<Failure, int>> getUnreadMessageCount();
}
