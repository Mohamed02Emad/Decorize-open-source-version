import 'package:decorizer/shared_features/chat/data/chat_end_points.dart';
import 'package:decorizer/shared_features/chat/domain/params/create_chat_params.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_chats_params.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_messages_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/data/remote/datasource_result.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/send_message_params.dart';

abstract class ChatDataSource {
  DatasourceResult getMessages(GetMessagesParams params);
  DatasourceResult getChats(GetChatsParams params);
  DatasourceResult sendMessage(SendMessageParams params);
  DatasourceResult createChat(CreateChatParams params);
  DatasourceResult getUnreadMessageCount();
}

@Injectable(as: ChatDataSource)
class ChatDataSourceImpl extends ChatDataSource {
  final ApiBaseHelper helper;

  ChatDataSourceImpl(this.helper);

  @override
  DatasourceResult createChat(CreateChatParams params) async {
    return await helper.post(
      url: ChatEndPoints.createChat,
      body: params.toJson(),
    );
  }

  @override
  DatasourceResult getMessages(GetMessagesParams params) async {
    return await helper.get(
      url: ChatEndPoints.messages(params.conversationId),
      queryParameters: params.toJson(),
    );
  }

  @override
  DatasourceResult sendMessage(SendMessageParams params) async {
    return await helper.post(
      url: ChatEndPoints.sendMessage,
      body: params.toJson(),
    );
  }

  @override
  DatasourceResult getChats(GetChatsParams params) async {
    return await helper.get(
      url: ChatEndPoints.chats,
      queryParameters: params.toJson(),
    );
  }

  @override
  DatasourceResult getUnreadMessageCount() async {
    return await helper.get(url: ChatEndPoints.getUnreadMessageCount);
  }
}
