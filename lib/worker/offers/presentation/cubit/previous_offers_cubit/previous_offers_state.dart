part of 'previous_offers_cubit.dart';


class GetPreviousOffersState extends Equatable {
  final RequestState<List<WorkerOfferModel>> getPreviousOffersState;

  GetPreviousOffersState.initial() : getPreviousOffersState = RequestState.initial();

  const GetPreviousOffersState({required this.getPreviousOffersState});

  GetPreviousOffersState copyWith({
    RequestState<List<WorkerOfferModel>>? getPreviousOffersState,
  }) {
    return GetPreviousOffersState(
      getPreviousOffersState:
      getPreviousOffersState ?? this.getPreviousOffersState,
    );
  }

  @override
  List<Object?> get props => [getPreviousOffersState];

}