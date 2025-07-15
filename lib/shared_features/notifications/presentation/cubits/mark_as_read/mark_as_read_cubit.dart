import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/notifications/domain/usecases/mark_notifications_as_read_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

part 'mark_as_read_state.dart';

@Injectable()
class MarkAsReadCubit extends BaseCubit<MarkAsReadState> {
  final MarkNotificationsAsReadUsecase markNotificationsAsReadUsecase;

  MarkAsReadCubit(this.markNotificationsAsReadUsecase)
      : super(MarkAsReadState.initial());

  Future<void> markAsRead() async {
    if (state.markAsReadState.isLoading) return;
    callAndFold(
      future: markNotificationsAsReadUsecase(NoParams()),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(markAsReadState: requestState)),
    );
  }
}
