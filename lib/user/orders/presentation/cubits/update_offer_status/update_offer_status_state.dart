part of 'update_offer_status_cubit.dart';

class UpdateOfferStatusState extends Equatable {
  final RequestState<Unit> acceptOfferState;
  final RequestState<Unit> rejectOfferState;

  UpdateOfferStatusState.initial() : acceptOfferState = RequestState.initial(), rejectOfferState = RequestState.initial();
  const UpdateOfferStatusState({required this.acceptOfferState, required this.rejectOfferState });

  UpdateOfferStatusState copyWith({
    RequestState<Unit>? acceptOfferState,
    RequestState<Unit>? rejectOfferState,
  }) {
    return UpdateOfferStatusState(
      acceptOfferState: acceptOfferState ?? this.acceptOfferState,
      rejectOfferState: rejectOfferState ?? this.rejectOfferState,
    );
  }

  @override
  List<Object?> get props => [acceptOfferState, rejectOfferState];
}
