import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/params/update_order_status_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UpdateOrderStatusUsecase extends UseCase<Unit, UpdateOrderStatusParams> {
  final UserOrdersRepository userOrdersRepository;

  UpdateOrderStatusUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, Unit>> call(UpdateOrderStatusParams params) async {
    return userOrdersRepository.updateOrderStatus(params);
  }
}
