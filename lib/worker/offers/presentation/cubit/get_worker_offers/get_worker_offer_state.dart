part of 'get_worker_offer_cubit.dart';

class GetWorkerOffersState extends Equatable {
  final RequestState<List<WorkerOfferModel>> getWorkerOffersState;

  GetWorkerOffersState.initial() : getWorkerOffersState = RequestState.initial();
  const GetWorkerOffersState({required this.getWorkerOffersState });

  GetWorkerOffersState copyWith({
    RequestState<List<WorkerOfferModel>>? getWorkerOffersState,
  }) {
    return GetWorkerOffersState(
      getWorkerOffersState: getWorkerOffersState ?? this.getWorkerOffersState,
    );
  }

  @override
  List<Object?> get props => [getWorkerOffersState];
}
