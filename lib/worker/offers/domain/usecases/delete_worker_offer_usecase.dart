import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/worker/offers/domain/params/delete_worker_offer_params.dart';
import 'package:decorizer/worker/offers/domain/repository/worker_offers_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteWorkerOfferUsecase extends UseCase<String, DeleteWorkerOfferParams> {
  final WorkerOffersRepository workerOffersRepository;

  DeleteWorkerOfferUsecase({required this.workerOffersRepository});

  @override
  Future<Either<Failure, String>> call(DeleteWorkerOfferParams params) async {
    return workerOffersRepository.deleteWorkerOffer(params);
  }
}