  import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/params/update_user_order_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserOrderUsecase extends UseCase<Unit, UpdateUserOrderParams> {
  final UserOrdersRepository userOrdersRepository;

  UpdateUserOrderUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, Unit>> call(UpdateUserOrderParams params) async {
    return userOrdersRepository.updateUserOrder(params);
  }
}
