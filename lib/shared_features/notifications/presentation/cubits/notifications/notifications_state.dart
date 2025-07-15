part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final RequestState<List<NotificationModel>> notificationsState;

  NotificationsState.initial() : notificationsState = RequestState.initial();
  const NotificationsState({required this.notificationsState });

  NotificationsState copyWith({
    RequestState<List<NotificationModel>>? notificationsState,
  }) {
    return NotificationsState(
      notificationsState: notificationsState ?? this.notificationsState,
    );
  }

  @override
  List<Object?> get props => [notificationsState ];
}
