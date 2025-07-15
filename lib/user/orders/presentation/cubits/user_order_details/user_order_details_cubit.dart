import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:decorizer/user/orders/domain/params/user_order_details_params.dart';
import 'package:decorizer/user/orders/domain/usecases/user_order_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'user_order_details_state.dart';

@injectable
class UserOrderDetailsCubit extends BaseCubit<UserOrderDetailsState> {
  final UserOrderDetailsUsecase userOrderDetailsUsecase;
  UserOrderDetailsCubit(this.userOrderDetailsUsecase)
      : super(UserOrderDetailsState.initial()) ;

  Future<void> getUserOrderDetails(int orderId) async {
    if (state.orderDetailsState.isLoading) return;
    callAndFold(
      future: userOrderDetailsUsecase(UserOrderDetailsParams(id: orderId.toString())),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(orderDetailsState: requestState)),
    );
  }

  void updateNumberOfApprovedOffers(int numberOfApprovedOffers) {
    final orderDetails = state.orderDetailsState.data;
    if (orderDetails != null) {
      final updatedOrderDetails = orderDetails.updateNumberOfApprovedOffers(numberOfApprovedOffers);
      emit(state.copyWith(orderDetailsState: RequestState.success(updatedOrderDetails)));
    }
  }

}