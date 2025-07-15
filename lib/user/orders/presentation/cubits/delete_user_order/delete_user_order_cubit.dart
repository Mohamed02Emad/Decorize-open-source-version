import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/params/delete_user_order_params.dart';
import 'package:decorizer/user/orders/domain/usecases/delete_user_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'delete_user_order_state.dart';

@Injectable()
class DeleteUserOrderCubit extends BaseCubit<DeleteUserOrderState> {
  final DeleteUserOrderUsecase deleteUserOrderUsecase;
  DeleteUserOrderCubit(this.deleteUserOrderUsecase)
      : super(DeleteUserOrderState.initial());

  Future<void> deleteUserOrder(String id) async {
    if (state.deleteUserOrderState.isLoading) return;
    callAndFold(
      future: deleteUserOrderUsecase(DeleteUserOrderParams(id: id)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(deleteUserOrderState: requestState)),
    );
  }
}
