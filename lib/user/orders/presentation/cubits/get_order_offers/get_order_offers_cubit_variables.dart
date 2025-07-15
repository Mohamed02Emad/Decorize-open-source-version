import 'package:decorizer/user/orders/domain/enums/offer_state.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin GetOrderOffersCubitVariables {
  OrderDetailsState? orderDetailsState;
  int? orderId;
  late final PagingController<int, OfferModel> paginateController;

  void initVariables(int orderId, OrderDetailsState? orderDetailsState) {
    this.orderId = orderId;
    this.orderDetailsState = orderDetailsState;
  }

  OfferState? get offerState {
    return switch (orderDetailsState) {
      OrderDetailsState.pending => null,
      OrderDetailsState.inProgress => OfferState.approved,
      OrderDetailsState.completed => OfferState.approved,
      OrderDetailsState.cancelled => OfferState.approved,
      null => null,
    };
  }

  void disposeVariables() {
    paginateController.dispose();
  }
}
