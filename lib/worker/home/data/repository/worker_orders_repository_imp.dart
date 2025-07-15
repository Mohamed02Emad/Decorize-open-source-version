
import 'package:dartz/dartz.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/worker/home/data/datasource/worker_home_remote_data_source.dart';
import 'package:decorizer/worker/home/domain/models/worker_order_model.dart';
import 'package:decorizer/worker/home/domain/params/get_worker_home_params.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/worker_order_details_model.dart';
import '../../domain/params/get_worker_order_details_params.dart';
import '../../domain/params/store_worker_offer_params.dart';
import '../../domain/repository/worker_home_repository.dart';


@Injectable(as: WorkerHomeRepository)
class WorkerHomeRepositoryImp implements WorkerHomeRepository {

  final WorkerHomeRemoteDataSource remoteDataSource;
  WorkerHomeRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<WorkerOrderModel>>> getOrders(GetWorkerHomeParams params){
    return remoteDataSource.getOrders(params).mapError((json) => ordersFromJson(json['data']));
  }

  @override
  Future<Either<Failure, WorkerOrderDetailsModel>> getWorkerOrderDetails(
      WorkerOrderDetailsParams params) {
    return remoteDataSource
        .getWorkerOrderDetails(params)
        .mapError((json) => WorkerOrderDetailsModel.fromJson(json['data']));
  }

  @override
  Future<Either<Failure, String>> storeWorkerOffer(StoreWorkerOffersParams params) {
    return remoteDataSource.storeWorkerOffer(params).mapError((json) => json['message'] ?? LocaleKeys.action_success.tr());
  }
}
