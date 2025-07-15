part of 'delete_worker_offer_cubit.dart';

class DeleteWorkerOfferState extends Equatable {
  final RequestState<String> deleteWorkerOfferState;

  DeleteWorkerOfferState.initial() : deleteWorkerOfferState = RequestState.initial();
  const DeleteWorkerOfferState({required this.deleteWorkerOfferState });

  DeleteWorkerOfferState copyWith({
    RequestState<String>? deleteWorkerOfferState,
  }) {
    return DeleteWorkerOfferState(
      deleteWorkerOfferState: deleteWorkerOfferState ?? this.deleteWorkerOfferState,
    );
  }

  @override
  List<Object?> get props => [deleteWorkerOfferState ];
}
