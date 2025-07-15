
part of 'store_offer_cubit.dart';
class StoreOfferState extends Equatable {
  final RequestState<String> storeOffer;

  StoreOfferState.initial() : storeOffer = RequestState.initial();

  const StoreOfferState({required this.storeOffer});

  StoreOfferState copyWith({
    RequestState<String>? storeOffer,
  }) {
    return StoreOfferState(
      storeOffer:
      storeOffer ?? this.storeOffer,
    );
  }

  @override
  List<Object?> get props => [storeOffer];

}
