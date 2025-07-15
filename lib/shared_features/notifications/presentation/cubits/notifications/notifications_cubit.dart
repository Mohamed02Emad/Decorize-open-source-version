import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/notifications/domain/models/notification_model.dart';
import 'package:decorizer/shared_features/notifications/domain/params/get_notifications_params.dart';
import 'package:decorizer/shared_features/notifications/domain/usecases/notifications_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
part 'notifications_state.dart';

@Injectable()
class NotificationsCubit extends BaseCubit<NotificationsState> {

  final ScrollController scrollController = ScrollController();
  late final PagingController<int, NotificationModel> paginateController;
  ValueNotifier<bool> showUpButton = ValueNotifier(false);

  final NotificationsUsecase notificationsUsecase;
  NotificationsCubit(this.notificationsUsecase)
      : super(NotificationsState.initial()){
    scrollController.addListener(_scrollListener);
    paginateController = PagingController(firstPageKey: 1);
    paginateController
        .addPageRequestListener((pageKey) => getNotifications(pageKey));
    getNotifications(1);
  }

 Future<void> getNotifications(int pageKey) async {
    if (state.notificationsState.isLoading) return;
    callAndFold(
      future: notificationsUsecase(GetNotificationsParams(page: pageKey)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(notificationsState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(notificationsState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            notificationsState:
                RequestState.success(paginateController.itemList ?? [])));
      },
    );
  }

   void refresh() async {
    paginateController.refresh();
  }

  void _scrollListener() {
    double offset = scrollController.offset;
    final newShowButton = offset > 320;
    if (newShowButton != showUpButton.value) {
      showUpButton.value = newShowButton;
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    paginateController.dispose();
    return super.close();
  }
}
