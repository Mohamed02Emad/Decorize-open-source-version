import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/paging/paginated_list_view.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/create_chat/create_chat_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/send_message/send_message_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/widgets/chat_title_bar.dart';
import 'package:decorizer/shared_features/chat/presentation/widgets/message_skeleton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav/nav.dart';

import '../../../../common/di/injection_container.dart';
import '../../../../common/util/ui_helper.dart';
import '../../../auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../cubits/messages/messages_cubit.dart';
import '../widgets/chat_send_message_section.dart';
import '../widgets/message_widget.dart';

class ChatDetailsScreen extends StatelessWidget {
  final ChatModel chatModel;

  const ChatDetailsScreen({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MessagesCubit>()
            ..init(
                conversationId: chatModel.id,
                currentUserId: sl<LoginInfoCubit>().user?.id ?? 0)
            ..connectChatChannel(channelName: 'private-chat.${chatModel.id}'),
        ),
        BlocProvider(
          create: (context) => sl<CreateChatCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SendMessageCubit>(),
        ),
      ],
      child: _ChatDetailsScreenBody(chatModel: chatModel),
    );
  }
}

class _ChatDetailsScreenBody extends StatelessWidget {
  final ChatModel chatModel;

  _ChatDetailsScreenBody({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    final cachedId = context.read<LoginInfoCubit>().user?.id;
    final otherUser = chatModel.userOne.id == cachedId
        ? chatModel.userTwo
        : chatModel.userOne;
    final currentUser = chatModel.userOne.id == cachedId
        ? chatModel.userOne
        : chatModel.userTwo;
    return MultiBlocListener(
      listeners: [
        BlocListener<MessagesCubit, MessagesState>(
          listenWhen: (previous, current) =>
              previous.messagesState != current.messagesState,
          listener: (context, state) {
            if (state.messagesState.isError) {
              showErrorToast(state.messagesState.message);
            }
          },
        ),
        BlocListener<SendMessageCubit, SendMessageState>(
          listenWhen: (previous, current) =>
              previous.sendMessageState != current.sendMessageState,
          listener: (context, state) => state.sendMessageState.listen(
            onSuccess: (message, _) {
              context.read<MessagesCubit>().upsertMessage(message);
            },
            onError: (errorMessage) {
              final message = state.sendMessageState.data;
              if (message != null) {
                context.read<MessagesCubit>().upsertMessage(message);
              }
            },
          ),
        ),
      ],
      child: Scaffold(
        appBar: ChatTitleBar(
          name: otherUser.name,
          image: otherUser.image ?? 'error',
          onBackPressed: () => _popWithUpdatedChat(context),
        ),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _popWithUpdatedChat(context);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: PaginatedListView(
                  reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  loadingItemBuilder: Column(
                    children: List.generate(
                      8,
                      (index) => MessageSkeletonWidget(
                        isMine: index % 3 == 0, // Mix of sent/received messages
                      ),
                    ),
                  ),
                  pagingController:
                      context.read<MessagesCubit>().paginateController,
                  onRetry: () => context.read<MessagesCubit>().refresh(),
                  itemBuilder: (context, message, index) {
                    return MessageWidget(
                      messageModel: message,
                      isMine: message.senderId == cachedId,
                    );
                  },
                  separatorHeight: 8.h,
                ),
              ),
              ChatSendMessageSection(
                onSendButtonPressed: (String message) {
                  final localMessage = MessageModel.local(
                    message,
                    DateTime.now().millisecondsSinceEpoch.toString(),
                    chatModel.id,
                    currentUser,
                  );
                  context.read<MessagesCubit>().upsertMessage(localMessage);
                  _sendMessage(context, localMessage);
                },
              ).marginTop(4.h).marginBottom(20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context, MessageModel localMessage) {
    context.read<SendMessageCubit>().sendMessage(localMessage: localMessage);
  }

  void _popWithUpdatedChat(BuildContext context) {
    context.read<UnreadMessageCountCubit>().getUnreadCount();
    final updatedCaht = chatModel.copyWith(
      lastMessage:
          context.read<MessagesCubit>().paginateController.itemList?.first,
      unreadMessagesCount: 0,
    );
    Nav.pop(context, result: updatedCaht);
  }
}
