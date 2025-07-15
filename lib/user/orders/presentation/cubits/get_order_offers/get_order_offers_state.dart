part of 'get_order_offers_cubit.dart';

class GetOrderOffersState extends Equatable {
  final RequestState<List<OfferModel>> getOrderOffersState;

  GetOrderOffersState.initial() : getOrderOffersState = RequestState.initial();
  const GetOrderOffersState({required this.getOrderOffersState });

  GetOrderOffersState copyWith({
    RequestState<List<OfferModel>>? getOrderOffersState,
  }) {
    return GetOrderOffersState(
      getOrderOffersState: getOrderOffersState ?? this.getOrderOffersState,
    );
  }

  @override
  List<Object?> get props => [getOrderOffersState ];
}
