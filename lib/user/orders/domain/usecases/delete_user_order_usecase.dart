import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/params/delete_user_order_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteUserOrderUsecase extends UseCase<Unit, DeleteUserOrderParams> {
  final UserOrdersRepository userOrdersRepository;

  DeleteUserOrderUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, Unit>> call(DeleteUserOrderParams params) async {
    return userOrdersRepository.deleteUserOrder(params);
  }
}
