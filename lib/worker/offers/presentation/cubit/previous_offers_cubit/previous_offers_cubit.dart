import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../../../../../common/base/baseCubit.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../../../../../common/util/guest_util.dart';
import '../../../domain/models/worker_offer_model.dart';
import '../../../domain/params/worker_offers_params.dart';
import '../../../domain/usecases/get_worker_offers_usecase.dart';
import 'previous_offers_cubit_variables.dart';

part 'previous_offers_state.dart';

@Injectable()
class GetPreviousOffersCubit extends BaseCubit<GetPreviousOffersState>
    with GetPreviousOffersCubitVariables {
  final GetWorkerOffersUseCase workerOffersUsecase;
  final LoginInfoCubit loginInfoCubit;
  GetPreviousOffersCubit(this.workerOffersUsecase, this.loginInfoCubit)
      : super(GetPreviousOffersState.initial()) {
    paginateController = PagingController(firstPageKey: 1);
    paginateController.addPageRequestListener((pageKey) => getWorkerOffers(pageKey));
    getWorkerOffers(1);
  }

  Future<void> getWorkerOffers(int pageKey ) async {
    if (state.getPreviousOffersState.isLoading || GuestUtil.isGuest) return;
    final cachedId = loginInfoCubit.user!.id.toString();
    final params = GetWorkerOffersParams(userId:cachedId,pageKey: pageKey, currentOffers: false , previousOffers: true);
    callAndFold(
        future: workerOffersUsecase(params),
        onDefaultEmit: (requestState) =>
            emit(state.copyWith(getPreviousOffersState: requestState)),
        error: (error) {
          paginateController.error = error;
          emit(state.copyWith(getPreviousOffersState: RequestState.error(error)));
        },
        success: (data) {
          if (data.length < 10) {
            paginateController.appendLastPage(data);
          } else {
            paginateController.appendPage(data, pageKey + 1);
          }
          emit(state.copyWith(
              getPreviousOffersState:
              RequestState.success(paginateController.itemList ?? [])));
        });
  }

  void refresh() async {
    paginateController.refresh();
  }

}