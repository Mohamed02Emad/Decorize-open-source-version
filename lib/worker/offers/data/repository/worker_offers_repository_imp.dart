import 'package:dartz/dartz.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../domain/models/worker_offer_model.dart';
import '../../domain/params/delete_worker_offer_params.dart';
import '../../domain/params/worker_offers_params.dart';
import '../../domain/repository/worker_offers_repository.dart';
import '../datatsource/worker_offers_remote_data_source.dart';


@Injectable(as: WorkerOffersRepository)
class WorkerOffersRepositoryImp implements WorkerOffersRepository {

  final WorkerOffersRemoteDataSource remoteDataSource;
  WorkerOffersRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WorkerOfferModel>>> getOffers(GetWorkerOffersParams params){
    return remoteDataSource.getOffers(params).mapError((json) => offersFromJson(json['data']));
  }

  @override
  Future<Either<Failure, String>> deleteWorkerOffer(DeleteWorkerOfferParams params) {
    return remoteDataSource.deleteWorkerOffer(params).mapError((json) => json['message'] ?? LocaleKeys.action_success.tr());
  }
}