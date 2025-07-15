import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/chat/domain/usecases/get_unread_message_count_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'unread_message_count_state.dart';

@LazySingleton()
class UnreadMessageCountCubit extends BaseCubit<UnreadMessageCountState> {
  final GetUnreadMessageCountUsecase getUnreadMessageCountUsecase;

  UnreadMessageCountCubit(this.getUnreadMessageCountUsecase)
      : super(UnreadMessageCountState.initial());

  Future<void> getUnreadCount() async {
    if (state.unreadCountState.isLoading) return;
    callAndFold(
      future: getUnreadMessageCountUsecase(NoParams()),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(unreadCountState: requestState)),
    );
  }

  void resetCount() {
    emit(state.copyWith(unreadCountState: RequestState.success(0)));
  }
}
