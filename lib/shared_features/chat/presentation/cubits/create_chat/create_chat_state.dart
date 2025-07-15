part of 'create_chat_cubit.dart';

@immutable
class CreateChatState extends Equatable {
  final RequestState<ChatModel> createChatState;

  CreateChatState.initial() : createChatState = RequestState<ChatModel>.initial();

  const CreateChatState({
    required this.createChatState,
  });

  CreateChatState copyWith({
    RequestState<ChatModel>? createChatState,
  }) {
    return CreateChatState(
      createChatState: createChatState ?? this.createChatState,
    );
  }

  @override
  List<Object?> get props => [
        createChatState,
      ];
}
