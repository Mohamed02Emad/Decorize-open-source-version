import 'package:dartz/dartz.dart';
import 'package:decorizer/worker/offers/domain/models/worker_offer_model.dart';
import '../../../../common/failure.dart';
import '../params/delete_worker_offer_params.dart';
import '../params/worker_offers_params.dart';

abstract class WorkerOffersRepository {
  Future<Either<Failure, List<WorkerOfferModel>>> getOffers(GetWorkerOffersParams params);
  Future<Either<Failure,String>> deleteWorkerOffer(DeleteWorkerOfferParams params);
}