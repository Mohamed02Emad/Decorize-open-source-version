import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/params/create_chat_params.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_chats_params.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_messages_params.dart';
import 'package:injectable/injectable.dart';

import '../../domain/params/send_message_params.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_data_source.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ChatModel>> createChat(CreateChatParams params) {
    return dataSource.createChat(params).mapError(
          (json) => ChatModel.fromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
      GetMessagesParams params) {
    return dataSource.getMessages(params).mapError(
          (json) => messageModelFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, MessageModel>> sendMessage(SendMessageParams params) {
    return dataSource.sendMessage(params).mapError(
          (json) => MessageModel.fromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, List<ChatModel>>> getChats(GetChatsParams params) {
    return dataSource.getChats(params).mapError(
          (json) => chatModelsFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, int>> getUnreadMessageCount() {
    return dataSource.getUnreadMessageCount().mapError(
          (json) => json['data']['unread_count'] ?? 0,
        );
  }
}
