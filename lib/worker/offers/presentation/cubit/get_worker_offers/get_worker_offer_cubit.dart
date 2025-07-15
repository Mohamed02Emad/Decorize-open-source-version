import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/domain/params/get_offers_params.dart';
import 'package:decorizer/user/orders/domain/usecases/get_order_offers_usecase.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit_variables.dart';
import 'package:decorizer/worker/offers/domain/Enum/worker_order_details_status.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/worker_offer_model.dart';
import '../../../domain/params/worker_offers_params.dart';
import '../../../domain/usecases/get_worker_offers_usecase.dart';
import 'get_worker_offer_cubit_variables.dart';
part 'get_worker_offer_state.dart';

@Injectable()
class GetWorkerOffersCubit extends BaseCubit<GetWorkerOffersState>
    with GetWorkerOffersCubitVariables {
  final GetWorkerOffersUseCase getWorkerOffersUsecase;
  GetWorkerOffersCubit(this.getWorkerOffersUsecase)
      : super(GetWorkerOffersState.initial()) {
    paginateController = PagingController(firstPageKey: 1);
    paginateController
        .addPageRequestListener((pageKey) => getWorkerOffers(pageKey));
  }

  void init(int orderId, WorkerOrderDetailsStatus? orderDetailsState) {
    initVariables(orderId, orderDetailsState);
    paginateController.itemList = [];
    getWorkerOffers(1);
  }

  Future<void> getWorkerOffers(int pageKey) async {
    if (state.getWorkerOffersState.isLoading) return;
    callAndFold(
      future: getWorkerOffersUsecase(
        GetWorkerOffersParams(
          pageKey: pageKey,
          postId: orderId.toString(),
          status: offerState,
        ),
      ),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(getWorkerOffersState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(getWorkerOffersState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            getWorkerOffersState:
            RequestState.success(paginateController.itemList ?? [])));
      },
    );
  }

  void refresh() async {
    paginateController.refresh();
  }

  @override
  Future<void> close() {
    disposeVariables();
    return super.close();
  }

  int get numberOfApprovedOffers => paginateController.itemList?.where((element) => element.status.isApproved).length ?? 0;
}