import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/base/usecase.dart';
import '../../../../common/failure.dart';
import '../params/add_rate_params.dart';
import '../repositories/user_orders_repository.dart';

@Injectable()
class AddRateUsecase extends UseCase<Unit, AddRateParams> {
  final UserOrdersRepository userOrdersRepository;

  AddRateUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, Unit>> call(AddRateParams params) async {
    return userOrdersRepository.addRate(params);
  }
}