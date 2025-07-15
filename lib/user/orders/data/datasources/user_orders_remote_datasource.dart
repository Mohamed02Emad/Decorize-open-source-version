import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/orders/data/orders_urls.dart';
import 'package:decorizer/user/orders/domain/params/delete_user_order_params.dart';
import 'package:decorizer/user/orders/domain/params/get_offers_params.dart';
import 'package:decorizer/user/orders/domain/params/get_user_orders_params.dart';
import 'package:decorizer/user/orders/domain/params/update_offer_status_params.dart';
import 'package:decorizer/user/orders/domain/params/update_order_status_params.dart';
import 'package:decorizer/user/orders/domain/params/user_order_details_params.dart';
import 'package:decorizer/user/orders/domain/params/update_user_order_params.dart';
import 'package:injectable/injectable.dart';

import '../../domain/params/add_rate_params.dart';

abstract class UserOrdersRemoteDatasource {
  DatasourceResult getUserOrders(GetUserOrdersParams params);
  DatasourceResult getUserOrderDetails(UserOrderDetailsParams params);
  DatasourceResult updateUserOrder(UpdateUserOrderParams params);
  DatasourceResult deleteUserOrder(DeleteUserOrderParams params);
  DatasourceResult getOffers(GetOffersParams params);
  DatasourceResult updateOfferStatus(UpdateOfferStatusParams params);
  DatasourceResult updateOrderStatus(UpdateOrderStatusParams params);
  DatasourceResult addRate(AddRateParams params);
}

@Injectable(as: UserOrdersRemoteDatasource)
class UserOrdersRemoteDatasourceImpl implements UserOrdersRemoteDatasource {
  final ApiBaseHelper apiHelper;
  UserOrdersRemoteDatasourceImpl({required this.apiHelper});

  @override
  DatasourceResult getUserOrders(GetUserOrdersParams params) {
    return apiHelper.get(url: OrdersUrls.getOrders, queryParameters: params.toJson());
  }

  @override
  DatasourceResult getUserOrderDetails(UserOrderDetailsParams params) {
    return apiHelper.get(
        url: OrdersUrls.getOrderById(params.id));
  }

  @override
  DatasourceResult updateUserOrder(UpdateUserOrderParams params) {
    return apiHelper.post(
        url: OrdersUrls.updateOrder(params.id), body: params.toJson());
  }

  @override
  DatasourceResult deleteUserOrder(DeleteUserOrderParams params) {
    return apiHelper.delete(url: OrdersUrls.deleteOrder(params.id));
  }

  @override
  DatasourceResult getOffers(GetOffersParams params) {
    return apiHelper.get(url: OrdersUrls.getOffers, queryParameters: params.toJson());
  }

  @override
  DatasourceResult updateOfferStatus(UpdateOfferStatusParams params) {
    return apiHelper.post(url: OrdersUrls.updateOfferStatus(params.offerId), body: params.toJson());
  }

  @override
  DatasourceResult updateOrderStatus(UpdateOrderStatusParams params) {
    return apiHelper.post(url: OrdersUrls.updateOrderStatus(params.orderId), body: params.toJson());
  }
  @override
  DatasourceResult addRate(AddRateParams params) {
    return apiHelper.post(url: OrdersUrls.addRate, body: params.toJson());
  }
}