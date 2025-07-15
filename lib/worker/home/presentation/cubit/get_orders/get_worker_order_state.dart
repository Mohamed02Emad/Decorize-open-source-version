

part of 'get_worker_orders_cubit.dart';

class GetWorkerOrdersState extends Equatable {
  final RequestState<List<WorkerOrderModel>> getWorkerOrdersState;

  GetWorkerOrdersState.initial() : getWorkerOrdersState = RequestState.initial();

  const GetWorkerOrdersState({required this.getWorkerOrdersState});

  GetWorkerOrdersState copyWith({
    RequestState<List<WorkerOrderModel>>? getWorkerOrdersState,
  }) {
    return GetWorkerOrdersState(
      getWorkerOrdersState:
          getWorkerOrdersState ?? this.getWorkerOrdersState,
    );
  }

  @override
  List<Object?> get props => [getWorkerOrdersState];

}