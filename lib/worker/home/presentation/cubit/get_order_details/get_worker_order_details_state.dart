part of 'get_worker_order_details_cubit.dart';


class WorkerOrderDetailsState extends Equatable {
  final RequestState<WorkerOrderDetailsModel> orderDetailsState;

  WorkerOrderDetailsState.initial() : orderDetailsState = RequestState.initial();
  const WorkerOrderDetailsState({required this.orderDetailsState });

  WorkerOrderDetailsState copyWith({
    RequestState<WorkerOrderDetailsModel>? orderDetailsState,
  }) {
    return WorkerOrderDetailsState(
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
    );
  }

  @override
  List<Object?> get props => [orderDetailsState ];
}