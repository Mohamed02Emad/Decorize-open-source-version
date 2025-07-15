part of 'chats_cubit.dart';

@immutable
class ChatsState extends Equatable {
  final RequestState<List<ChatModel>> chatsState;

  ChatsState.initial() : chatsState = RequestState<List<ChatModel>>.initial();

  const ChatsState({
    required this.chatsState,
  });

  ChatsState copyWith({
    RequestState<List<ChatModel>>? chatsState,
  }) {
    return ChatsState(
      chatsState: chatsState ?? this.chatsState,
    );
  }

  @override
  List<Object?> get props => [
        chatsState,
      ];
}
