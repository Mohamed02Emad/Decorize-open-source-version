import 'package:decorizer/user/orders/domain/enums/offer_state.dart';

class GetOffersParams {
  final int page;
  final String orderId;
  final OfferState? offerState;

  GetOffersParams({required this.orderId, required this.offerState, required this.page});

  Map<String, dynamic> toJson() {
    return {
      'post_id': orderId,
      if (offerState != null) 'status': offerState!.statusKey,
      'page': page,
    };
  }
}
