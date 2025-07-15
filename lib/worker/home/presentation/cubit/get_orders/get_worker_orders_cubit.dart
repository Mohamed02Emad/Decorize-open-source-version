import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/worker/home/domain/params/get_worker_home_params.dart';
import 'package:decorizer/worker/home/presentation/cubit/get_orders/get_worker_orders_variables.dart';
import 'package:flutter/animation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/worker_order_model.dart';
import '../../../../../common/base/baseCubit.dart';
import '../../../../../common/util/guest_util.dart';
import '../../../domain/usecases/get_worker_orders_usecase.dart';
part 'get_worker_order_state.dart';

@Injectable()
class GetWorkerOrdersCubit extends BaseCubit<GetWorkerOrdersState>
    with GetWorkerOrdersCubitVariables {
  final GetWorkerOrdersUseCase workerOrdersUsecase;
  GetWorkerOrdersCubit(this.workerOrdersUsecase)
      : super(GetWorkerOrdersState.initial()) {
    scrollController.addListener(_scrollListener);
    paginateController = PagingController(firstPageKey: 1);
    paginateController.addPageRequestListener((pageKey) => getWorkerOrders(pageKey));
    getWorkerOrders(1);
  }

  Future<void> getWorkerOrders(int pageKey) async {
    if (state.getWorkerOrdersState.isLoading || GuestUtil.isGuest) return;
    final params = GetWorkerHomeParams(pageKey: pageKey);
    callAndFold(
        future: workerOrdersUsecase(params),
        onDefaultEmit: (requestState) =>
            emit(state.copyWith(getWorkerOrdersState: requestState)),
        error: (error) {
          paginateController.error = error;
          emit(state.copyWith(getWorkerOrdersState: RequestState.error(error)));
        },
        success: (List<WorkerOrderModel> data) {
          if (data.length < 10) {
            paginateController.appendLastPage(data);
          } else {
            paginateController.appendPage(data, pageKey + 1);
          }
          emit(state.copyWith(
              getWorkerOrdersState:
                  RequestState.success(paginateController.itemList ?? [])));
        });
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
}
