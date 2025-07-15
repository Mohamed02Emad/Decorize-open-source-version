import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/domain/params/get_offers_params.dart';
import 'package:decorizer/user/orders/domain/repositories/user_orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetOrderOffersUsecase extends UseCase<List<OfferModel>, GetOffersParams> {
  final UserOrdersRepository userOrdersRepository;

  GetOrderOffersUsecase({required this.userOrdersRepository});

  @override
  Future<Either<Failure, List<OfferModel>>> call(GetOffersParams params) async {
    return userOrdersRepository.getOffers(params);
  }
}
