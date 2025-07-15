import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:decorizer/user/orders/domain/params/get_user_orders_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserOrdersUsecase extends UseCase<List<OrderModel>, GetUserOrdersParams> {
  final UserOrdersRepository userOrdersRepository;

  UserOrdersUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, List<OrderModel>>> call(GetUserOrdersParams params) async {
    return userOrdersRepository.getUserOrders(params);
  }
}
