import 'package:decorizer/worker/offers/domain/Enum/worker_offer_state.dart';

class GetWorkerOffersParams {
  String? userId ;
  final bool? currentOffers;
  final bool? previousOffers;
  final String? postId;
  final WorkerOfferState? status;
  final int pageKey;

  GetWorkerOffersParams({this.userId,  this.currentOffers,  this.previousOffers, required this.pageKey,this.postId, this.status});
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'current' : currentOffers,
    'previous' : previousOffers,
    'post_id': postId,
    if (status != null) 'status': status!.statusKey,
    'page': pageKey,
  };
}
