import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/data/datasources/user_orders_remote_datasource.dart';
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
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/params/add_rate_params.dart';

@Injectable(as: UserOrdersRepository)
class UserOrdersRepositoryImpl extends UserOrdersRepository {
  final UserOrdersRemoteDatasource remoteDatasource;
  UserOrdersRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders(GetUserOrdersParams params) {
    return remoteDatasource.getUserOrders(params).mapError((json) => ordersFromJson(json['data']));
  }

  @override
  Future<Either<Failure, OrderDetailsModel>> getUserOrderDetails(
      UserOrderDetailsParams params) {
    return remoteDatasource
        .getUserOrderDetails(params)
        .mapError((json) => OrderDetailsModel.fromJson(json['data']));
  }

  @override
  Future<Either<Failure, Unit>> updateUserOrder(UpdateUserOrderParams params) {
    return remoteDatasource.updateUserOrder(params).mapError((json) => unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteUserOrder(DeleteUserOrderParams params) {
    return remoteDatasource.deleteUserOrder(params).mapError((json) => unit);
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers(GetOffersParams params) {
    return remoteDatasource.getOffers(params).mapError((json) => offersFromJson(json['data']));
  }

  @override
  Future<Either<Failure, Unit>> updateOfferStatus(UpdateOfferStatusParams params) {
    return remoteDatasource.updateOfferStatus(params).mapError((json) => unit);
  }

  @override
  Future<Either<Failure, Unit>> updateOrderStatus(UpdateOrderStatusParams params) {
    return remoteDatasource.updateOrderStatus(params).mapError((json) => unit);
  }
  @override
  Future<Either<Failure, Unit>> addRate(AddRateParams params) {
    return remoteDatasource.addRate(params).mapError((json) => unit);
  }
}