part of 'current_offers_cubit.dart';


class GetCurrentOffersState extends Equatable {
  final RequestState<List<WorkerOfferModel>> getCurrentOffersState;

  GetCurrentOffersState.initial() : getCurrentOffersState = RequestState.initial();

  const GetCurrentOffersState({required this.getCurrentOffersState});

  GetCurrentOffersState copyWith({
    RequestState<List<WorkerOfferModel>>? getCurrentOffersState,
  }) {
    return GetCurrentOffersState(
      getCurrentOffersState:
      getCurrentOffersState ?? this.getCurrentOffersState,
    );
  }

  @override
  List<Object?> get props => [getCurrentOffersState];

}