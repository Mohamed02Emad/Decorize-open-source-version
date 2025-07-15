part of 'send_message_cubit.dart';

@immutable
class SendMessageState extends Equatable {
  final RequestState<MessageModel> sendMessageState;

  SendMessageState.initial() : sendMessageState = RequestState<MessageModel>.initial();

  const SendMessageState({
    required this.sendMessageState,
  });

  SendMessageState copyWith({
    RequestState<MessageModel>? sendMessageState,
  }) {
    return SendMessageState(
      sendMessageState: sendMessageState ?? this.sendMessageState,
    );
  }

  @override
  List<Object?> get props => [
        sendMessageState,
      ];
}
