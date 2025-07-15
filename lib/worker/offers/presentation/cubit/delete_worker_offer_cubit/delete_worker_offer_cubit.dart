import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/params/delete_worker_offer_params.dart';
import '../../../domain/usecases/delete_worker_offer_usecase.dart';
part 'delete_worker_offer_state.dart';

@Injectable()
class DeleteWorkerOfferCubit extends BaseCubit<DeleteWorkerOfferState> {
  final DeleteWorkerOfferUsecase deleteWorkerOfferUsecase;
  DeleteWorkerOfferCubit(this.deleteWorkerOfferUsecase)
      : super(DeleteWorkerOfferState.initial());
  final TextEditingController cancelController = TextEditingController();

  Future<void> deleteWorkerOffer(String id) async {
    if (state.deleteWorkerOfferState.isLoading) return;
    callAndFold(
      future: deleteWorkerOfferUsecase(DeleteWorkerOfferParams(postId: id)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(deleteWorkerOfferState: requestState)),
    );
  }
}
