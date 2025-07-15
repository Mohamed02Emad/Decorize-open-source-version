import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';

class GetUserOrdersParams {
  final int page;
  final String? query;
  final OrderDetailsState? status;

  GetUserOrdersParams(
      {required this.page, required this.status, required this.query});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (query != null) 'search': query,
      if (status != null) 'status': status?.statusKey,
    };
  }
}
