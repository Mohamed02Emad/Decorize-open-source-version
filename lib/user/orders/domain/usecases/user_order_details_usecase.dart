import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:decorizer/user/orders/domain/params/user_order_details_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserOrderDetailsUsecase extends UseCase<OrderDetailsModel, UserOrderDetailsParams> {
  final UserOrdersRepository userOrdersRepository;

  UserOrderDetailsUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, OrderDetailsModel>> call(UserOrderDetailsParams params) async {
    return userOrdersRepository.getUserOrderDetails(params);
  }
}