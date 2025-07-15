import 'package:decorizer/worker/home/domain/params/store_worker_offer_params.dart';
import 'package:decorizer/worker/home/domain/usecases/store_worker_offer_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/base/baseCubit.dart';
import '../../../../../common/data/remote/request_state.dart';
part 'store_offer_state.dart';

@Injectable()
class StoreOfferCubit extends BaseCubit<StoreOfferState> {
  StoreOfferCubit(this._storeWorkerOfferUseCase)
      : super(StoreOfferState.initial());
 final StoreWorkerOfferUseCase _storeWorkerOfferUseCase;

  final TextEditingController servicePriceController = TextEditingController();
  final TextEditingController estimatedDurationController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  Future<void> storeOffer(int postId) async {
    if (state.storeOffer.isLoading) return;
    final servicePrice = servicePriceController.text;
    final estimatedDuration = estimatedDurationController.text;
    final comment = commentController.text;

    final param = StoreWorkerOffersParams(
      postId: postId,
      budget: servicePrice,
      numberOfDays: estimatedDuration,
      description: comment
    );
    callAndFold(
      future: _storeWorkerOfferUseCase(param),
      onDefaultEmit: (storeOffer) {
        emit(state.copyWith(storeOffer: storeOffer));
      },
    );
  }

}
