import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/worker/offers/domain/models/worker_offer_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/base/usecase.dart';
import '../params/worker_offers_params.dart';
import '../repository/worker_offers_repository.dart';


@Injectable()
class   GetWorkerOffersUseCase extends UseCase<List<WorkerOfferModel>,GetWorkerOffersParams> {

  GetWorkerOffersUseCase({required this.workerOffersRepository,});
  final WorkerOffersRepository workerOffersRepository;

  @override
  Future<Either<Failure , List<WorkerOfferModel>>> call(GetWorkerOffersParams params) async {
    return workerOffersRepository.getOffers(params);
  }
}