import 'package:decorizer/user/orders/domain/enums/offer_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../worker/offers/domain/Enum/worker_order_details_status.dart';
import '../../../domain/Enum/worker_offer_state.dart';
import '../../../domain/models/worker_offer_model.dart';

mixin GetWorkerOffersCubitVariables {
  WorkerOrderDetailsStatus? orderDetailsState;
  int? orderId;
  late final PagingController<int, WorkerOfferModel> paginateController;

  void initVariables(int orderId, WorkerOrderDetailsStatus? orderDetailsState) {
    this.orderId = orderId;
    this.orderDetailsState = orderDetailsState;
  }

  WorkerOfferState? get offerState {
    return switch (orderDetailsState) {
      WorkerOrderDetailsStatus.pending => null,
      WorkerOrderDetailsStatus.inProgress => WorkerOfferState.approved,
      WorkerOrderDetailsStatus.completed => WorkerOfferState.approved,
      WorkerOrderDetailsStatus.cancelled => WorkerOfferState.approved,
      null => null,
    };
  }

  void disposeVariables() {
    paginateController.dispose();
  }
}