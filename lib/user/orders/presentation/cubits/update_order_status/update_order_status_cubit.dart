import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/params/update_order_status_params.dart';
import 'package:decorizer/user/orders/domain/usecases/update_order_status_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'update_order_status_state.dart';

@Injectable()
class UpdateOrderStatusCubit extends BaseCubit<UpdateOrderStatusState> {
  final UpdateOrderStatusUsecase updateOrderStatusUsecase;
  UpdateOrderStatusCubit(this.updateOrderStatusUsecase)
      : super(UpdateOrderStatusState.initial());

  Future<void> startWork({
    required String orderId,
  }) async {
    if (state.startWorkState.isLoading) return;
    final params = UpdateOrderStatusParams(
      orderId: orderId,
      status: OrderDetailsState.inProgress.statusKey,
    );
    callAndFold(
      future: updateOrderStatusUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(startWorkState: requestState)),
    );
  }

  Future<void> cancelOrder({required String orderId, String? reason}) async {
    if (state.cancelOrderState.isLoading) return;
    final params = UpdateOrderStatusParams(
      orderId: orderId,
      status: OrderDetailsState.cancelled.statusKey,
      reason: reason,
    );
    callAndFold(
      future: updateOrderStatusUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(cancelOrderState: requestState)),
    );
  }

  Future<void> endWork({required String orderId}) async {
    if (state.endWorkState.isLoading) return;
    final params = UpdateOrderStatusParams(
      orderId: orderId,
      status: OrderDetailsState.completed.statusKey,
    );
    callAndFold(
      future: updateOrderStatusUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(endWorkState: requestState)),
    );
  }
}
