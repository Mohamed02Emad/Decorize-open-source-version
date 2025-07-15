import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/enums/offer_state.dart';
import 'package:decorizer/user/orders/domain/params/update_offer_status_params.dart';
import 'package:decorizer/user/orders/domain/usecases/update_offer_status_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'update_offer_status_state.dart';

@Injectable()
class UpdateOfferStatusCubit extends BaseCubit<UpdateOfferStatusState> {
  final UpdateOfferStatusUsecase updateOfferStatusUsecase;
  UpdateOfferStatusCubit(this.updateOfferStatusUsecase)
      : super(UpdateOfferStatusState.initial());

  Future<void> acceptOffer({
    required String offerId,
  }) async {
    if (state.acceptOfferState.isLoading) return;
    final params = UpdateOfferStatusParams(
      offerId: offerId,
      status: OfferState.approved.statusKey,
    );
    callAndFold(
      future: updateOfferStatusUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(acceptOfferState: requestState)),
    );
  }

  Future<void> rejectOffer({required String offerId, String? reason}) async {
    if (state.rejectOfferState.isLoading) return;
    final params = UpdateOfferStatusParams(
      offerId: offerId,
      status: OfferState.rejected.statusKey,
      reason: reason,
    );
    callAndFold(
      future: updateOfferStatusUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(rejectOfferState: requestState)),
    );
  }
}
