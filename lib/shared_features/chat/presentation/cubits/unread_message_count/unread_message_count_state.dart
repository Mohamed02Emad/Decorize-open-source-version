part of 'unread_message_count_cubit.dart';

class UnreadMessageCountState extends Equatable {
  final RequestState<int> unreadCountState;

  UnreadMessageCountState.initial() : unreadCountState = RequestState.initial();
  const UnreadMessageCountState({required this.unreadCountState});

  UnreadMessageCountState copyWith({
    RequestState<int>? unreadCountState,
  }) {
    return UnreadMessageCountState(
      unreadCountState: unreadCountState ?? this.unreadCountState,
    );
  }

  @override
  List<Object?> get props => [unreadCountState];
}
