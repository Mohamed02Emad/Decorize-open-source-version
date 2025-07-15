import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/params/add_rate_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/add_rate_usecase.dart';
part 'add_rate_state.dart';

@Injectable()
class AddRateCubit extends BaseCubit<AddRateState> {
  final AddRateUsecase addRateUsecase;
  AddRateCubit(this.addRateUsecase)
      : super(AddRateState.initial());

   TextEditingController rateCommentController = TextEditingController();
   int rate = 0;

  Future<void> AddRate({required int workerId}) async {
    if (state.addRateState.isLoading) return;
    final params = AddRateParams(workerId: workerId, rate: rate, comment: rateCommentController.text);
    callAndFold(
      future: addRateUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(addRateState: requestState)),
    );
  }
}
