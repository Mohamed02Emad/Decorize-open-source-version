import 'package:decorizer/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:decorizer/user/orders/domain/params/delete_user_order_params.dart';
import 'package:decorizer/user/orders/domain/params/get_offers_params.dart';
import 'package:decorizer/user/orders/domain/params/get_user_orders_params.dart';
import 'package:decorizer/user/orders/domain/params/update_offer_status_params.dart';
import 'package:decorizer/user/orders/domain/params/update_order_status_params.dart';
import 'package:decorizer/user/orders/domain/params/user_order_details_params.dart';
import 'package:decorizer/user/orders/domain/params/update_user_order_params.dart';

import '../params/add_rate_params.dart';

abstract class UserOrdersRepository {
  Future<Either<Failure, List<OrderModel>>> getUserOrders(GetUserOrdersParams params);
  Future<Either<Failure, OrderDetailsModel>> getUserOrderDetails(
      UserOrderDetailsParams params);
  Future<Either<Failure, Unit>> updateUserOrder(UpdateUserOrderParams params);
  Future<Either<Failure, Unit>> deleteUserOrder(DeleteUserOrderParams params);
  Future<Either<Failure, List<OfferModel>>> getOffers(GetOffersParams params);
  Future<Either<Failure, Unit>> updateOfferStatus(UpdateOfferStatusParams params);
  Future<Either<Failure, Unit>> updateOrderStatus(UpdateOrderStatusParams params);
  Future<Either<Failure, Unit>> addRate(AddRateParams params);
}