import 'dart:convert';
import 'dart:developer';

import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/usecases/get_chats_use_case.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/params/get_chats_params.dart';

part 'chats_state.dart';

@Injectable()
class ChatsCubit extends BaseCubit<ChatsState> {
  ChatsCubit(
    this.getChatsUseCase,
    this.pusher,
  ) : super(ChatsState.initial()) {
    scrollController.addListener(_scrollListener);
    _startPagination();
  }
  final GetChatsUseCase getChatsUseCase;

  final ScrollController scrollController = ScrollController();
  late final PagingController<int, ChatModel> paginateController;
  ValueNotifier<bool> showUpButton = ValueNotifier(false);
  final PusherChannelsFlutter pusher;
  PusherChannel? _pusherChannel;

  Future<void> _startPagination() async {
    paginateController = PagingController(firstPageKey: 1);
    paginateController.addPageRequestListener((pageKey) => getChats(pageKey));
    getChats(1);
  }

  Future<void> getChats(int pageKey) async {
    if (state.chatsState.isLoading) return;
    callAndFold(
      future: getChatsUseCase(GetChatsParams(page: pageKey)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(chatsState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(chatsState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            chatsState:
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

  void connectChatChannel({required String channelName}) async {
    if (GuestUtil.isGuest) return;
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
      if (event.eventName == 'chat.updated') {
        final jsonData = json.decode(event.data);
        final ChatModel chat = ChatModel.fromJson(jsonData["chat"]);
        if (isClosed) return;
        upsertChat(chat);
        //دي جريمه مينغعش كيوبت يخش جوا كيوبت انا بس بنجز الدنيا 
        sl<UnreadMessageCountCubit>().getUnreadCount();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void upsertChat(ChatModel chat) {
    final List<ChatModel> chats = List.from(state.chatsState.data ?? []);
    final index = chats.indexWhere((element) => element.id == chat.id);
    if (index != -1) {
      chats[index] = chat;
    } else {
      chats.insert(0, chat);
    }
    paginateController.itemList = chats;
    paginateController.notifyListeners();
    emit(state.copyWith(
      chatsState: RequestState.success(
        chats,
      ),
    ));
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
