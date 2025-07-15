import 'package:decorizer/worker/offers/domain/models/worker_offer_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin GetPreviousOffersCubitVariables {
  late final PagingController<int, WorkerOfferModel> paginateController;
  late final List<WorkerOfferModel> offers ;
}