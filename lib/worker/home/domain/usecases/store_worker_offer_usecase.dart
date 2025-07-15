import 'package:dartz/dartz.dart';
import 'package:decorizer/worker/home/domain/params/store_worker_offer_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/usecase.dart';
import '../../../../common/failure.dart';
import '../repository/worker_home_repository.dart';

@Injectable()
class StoreWorkerOfferUseCase extends UseCase<String,StoreWorkerOffersParams> {

  StoreWorkerOfferUseCase({required this.workerHomeRepository,});
  final WorkerHomeRepository workerHomeRepository;

  @override
  Future<Either<Failure , String>> call(StoreWorkerOffersParams params) async {
    return workerHomeRepository.storeWorkerOffer(params);
  }
}
