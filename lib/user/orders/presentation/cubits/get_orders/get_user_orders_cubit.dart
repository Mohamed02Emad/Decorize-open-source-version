import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:decorizer/user/orders/domain/params/get_user_orders_params.dart';
import 'package:decorizer/user/orders/domain/usecases/user_orders_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import 'get_user_orders_cubit_variables.dart';
part 'get_user_orders_state.dart';

@singleton
class GetUserOrdersCubit extends BaseCubit<GetUserOrdersState>
    with GetUserOrdersCubitVariables {
  final UserOrdersUsecase userOrdersUsecase;
  GetUserOrdersCubit(this.userOrdersUsecase)
      : super(GetUserOrdersState.initial()) {
    scrollController.addListener(_scrollListener);
    paginateController = PagingController(firstPageKey: 1);
    paginateController.addPageRequestListener((pageKey) => getUserOrders(pageKey));
  }

  void startPagination() {
    if (GuestUtil.isGuest) return;
    refresh();
  }

  Future<void> getUserOrders(int pageKey) async {
    if (state.getUserOrdersState.isLoading || GuestUtil.isGuest) return;
    callAndFold(
      future: userOrdersUsecase(GetUserOrdersParams(
          page: pageKey,
          query: searchController.text,
          status: statusNotifier.value)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(getUserOrdersState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(getUserOrdersState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            getUserOrdersState:
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

  void removeOrderFromList(OrderModel order) {
    final newList = paginateController.itemList
        ?.where((element) => element.id != order.id)
        .toList();
    paginateController.itemList = newList;
    emit(state.copyWith(
        getUserOrdersState: RequestState.success(newList ?? [])));
  }
}
