import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/notifications/domain/usecases/get_unread_notifications_count_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'unread_notifications_count_state.dart';

@LazySingleton()
class UnreadNotificationsCountCubit
    extends BaseCubit<UnreadNotificationsCountState> {
  final GetUnreadNotificationsCountUsecase getUnreadNotificationsCountUsecase;

  UnreadNotificationsCountCubit(this.getUnreadNotificationsCountUsecase)
      : super(UnreadNotificationsCountState.initial());

  Future<void> getUnreadCount() async {
    if (state.unreadCountState.isLoading) return;
    callAndFold(
      future: getUnreadNotificationsCountUsecase(NoParams()),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(unreadCountState: requestState)),
    );
  }

  void resetCount() {
    emit(state.copyWith(unreadCountState: RequestState.success(0)));
  }
}
