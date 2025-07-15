import 'dart:convert';
import 'dart:developer';

import 'package:decorizer/shared_features/chat/domain/enums/message_status.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_messages_params.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/usecases/get_messages_use_case.dart';

part 'messages_state.dart';

@Injectable()
class MessagesCubit extends BaseCubit<MessagesState> {
  MessagesCubit(
    this.getMessagesUseCase,
    this.pusher,
  ) : super(MessagesState.initial());
  final GetMessagesUseCase getMessagesUseCase;

  final ScrollController scrollController = ScrollController();
  late final PagingController<int, MessageModel> paginateController;
  ValueNotifier<bool> showUpButton = ValueNotifier(false);
  final PusherChannelsFlutter pusher;
  PusherChannel? _pusherChannel;
  late int  currentUserId;

  init({required int? conversationId, required int currentUserId}) {
    this.currentUserId = currentUserId;
    scrollController.addListener(_scrollListener);
    if (conversationId != null) {
      _startPagination(conversationId);
    } else {
      paginateController = PagingController(firstPageKey: 1);
      paginateController.appendLastPage([]);
    }
  }

  Future<void> _startPagination(int conversationId) async {
    paginateController = PagingController(firstPageKey: 1);
    paginateController.addPageRequestListener((pageKey) =>
        getMessages(page: pageKey, conversationId: conversationId));
    getMessages(page: 1, conversationId: conversationId);
  }

  Future<void> getMessages(
      {required int page, required int conversationId}) async {
    if (state.messagesState.isLoading) return;
    callAndFold(
      future: getMessagesUseCase(
          GetMessagesParams(page: page, conversationId: conversationId)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(messagesState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(messagesState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, page + 1);
        }
        emit(state.copyWith(
            messagesState:
                RequestState.success(paginateController.itemList ?? [])));
      },
    );
  }

  void refresh() async {
    paginateController.refresh();
  }

  void _scrollListener() {
    double offset = scrollController.offset;
    final newShowButton = offset > 320;
    if (newShowButton != showUpButton.value) {
      showUpButton.value = newShowButton;
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
    );
  }

  void connectChatChannel({
    required String channelName,
  }) async {
    try {
      _pusherChannel?.unsubscribe();
      _pusherChannel = await pusher.subscribe(
        channelName: channelName,
        onSubscriptionError: (e) {
          log("onSubscriptionError: $e");
        },
        onSubscriptionSucceeded: (d) {
          log("onSubscriptionSucceeded: $d");
        },
        onEvent: (event) => _onEvent(event),
      );
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void _onEvent(dynamic event) async {
    try {
      log("onEvent: $event");
      if (event.eventName == r"App\Events\MessageSent") {
        final jsonData = json.decode(event.data);
        final MessageModel message = MessageModel.fromJson(jsonData);
        if (isClosed || message.senderId == currentUserId) return;
        upsertMessage(message.copyWith(status: MessageStatus.sent));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  upsertMessage(MessageModel message) {
    final currentMessages =
        List<MessageModel>.from(paginateController.itemList ?? []);
    final index = currentMessages
        .indexWhere((element) => element.localId == message.localId && element.localId != null);

    if (index != -1) {
      currentMessages[index] = message;
    } else {
      currentMessages.insert(0, message);
    }

    paginateController.itemList = currentMessages;
    paginateController.notifyListeners();

    emit(state.copyWith(messagesState: RequestState.success(currentMessages)));
  }

  @override
  Future<void> close() {
    _unSubscribe();
    scrollController.dispose();
    paginateController.dispose();
    showUpButton.dispose();
    return super.close();
  }

  void _unSubscribe() {
    _pusherChannel?.unsubscribe();
  }
}
