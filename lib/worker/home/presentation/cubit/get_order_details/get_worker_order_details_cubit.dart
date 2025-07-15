import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/worker_order_details_model.dart';
import '../../../domain/params/get_worker_order_details_params.dart';
import '../../../domain/usecases/get_worker_order_details_usecase.dart';
part 'get_worker_order_details_state.dart';

@injectable
class WorkerOrderDetailsCubit extends BaseCubit<WorkerOrderDetailsState> {
  final WorkerOrderDetailsUsecase workerOrderDetailsUsecase;
  WorkerOrderDetailsCubit(this.workerOrderDetailsUsecase)
      : super(WorkerOrderDetailsState.initial()) ;

  Future<void> getWorkerOrderDetails(int orderId) async {
    if (state.orderDetailsState.isLoading) return;
    callAndFold(
      future: workerOrderDetailsUsecase(WorkerOrderDetailsParams(id: orderId.toString())),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(orderDetailsState: requestState)),
    );
  }

}