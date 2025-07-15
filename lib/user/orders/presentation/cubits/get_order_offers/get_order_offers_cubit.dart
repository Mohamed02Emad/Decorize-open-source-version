import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/domain/params/get_offers_params.dart';
import 'package:decorizer/user/orders/domain/usecases/get_order_offers_usecase.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit_variables.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
part 'get_order_offers_state.dart';

@Injectable()
class GetOrderOffersCubit extends BaseCubit<GetOrderOffersState>
    with GetOrderOffersCubitVariables {
  final GetOrderOffersUsecase getOrderOffersUsecase;
  GetOrderOffersCubit(this.getOrderOffersUsecase)
      : super(GetOrderOffersState.initial()) {
    paginateController = PagingController(firstPageKey: 1);
    paginateController
        .addPageRequestListener((pageKey) => getOrderOffers(pageKey));
  }

  void init(int orderId, OrderDetailsState? orderDetailsState) {
    initVariables(orderId, orderDetailsState);
    paginateController.itemList = [];
    getOrderOffers(1);
  }

  Future<void> getOrderOffers(int pageKey) async {
    if (state.getOrderOffersState.isLoading) return;
    callAndFold(
      future: getOrderOffersUsecase(
        GetOffersParams(
          page: pageKey,
          orderId: orderId.toString(),
          offerState: offerState,
        ),
      ),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(getOrderOffersState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(getOrderOffersState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            getOrderOffersState:
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

  void updateOffer(OfferModel updatedOffer) {
    final offers = List<OfferModel>.from(paginateController.itemList ?? []);
    final index = offers.indexWhere((element) => element.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      paginateController.itemList = offers;
      emit(state.copyWith(
          getOrderOffersState:
              RequestState.success(paginateController.itemList ?? [])));
    }
  }

  int get numberOfApprovedOffers => paginateController.itemList?.where((element) => element.status.isApproved).length ?? 0;
}
