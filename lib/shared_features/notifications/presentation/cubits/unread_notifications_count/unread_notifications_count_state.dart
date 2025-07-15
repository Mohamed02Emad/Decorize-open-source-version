part of 'unread_notifications_count_cubit.dart';

class UnreadNotificationsCountState extends Equatable {
  final RequestState<int> unreadCountState;

  UnreadNotificationsCountState.initial()
      : unreadCountState = RequestState.initial();
  const UnreadNotificationsCountState({required this.unreadCountState});

  UnreadNotificationsCountState copyWith({
    RequestState<int>? unreadCountState,
  }) {
    return UnreadNotificationsCountState(
      unreadCountState: unreadCountState ?? this.unreadCountState,
    );
  }

  @override
  List<Object?> get props => [unreadCountState];
}
