part of 'messages_cubit.dart';

@immutable
class MessagesState extends Equatable {
  final RequestState<List<MessageModel>> messagesState;

  MessagesState.initial() : messagesState = RequestState<List<MessageModel>>.initial();

  const MessagesState({
    required this.messagesState,
  });

  MessagesState copyWith({
    RequestState<List<MessageModel>>? messagesState,
  }) {
    return MessagesState(
      messagesState: messagesState ?? this.messagesState,
    );
  }

  @override
  List<Object?> get props => [
        messagesState,
      ];
}
