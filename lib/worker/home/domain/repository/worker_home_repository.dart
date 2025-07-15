import 'package:dartz/dartz.dart';
import 'package:decorizer/worker/home/domain/models/worker_order_model.dart';
import 'package:decorizer/worker/home/domain/params/get_worker_home_params.dart';
import 'package:decorizer/worker/home/domain/params/store_worker_offer_params.dart';
import '../../../../common/failure.dart';
import '../models/worker_order_details_model.dart';
import '../params/get_worker_order_details_params.dart';

abstract class WorkerHomeRepository {
  Future<Either<Failure, List<WorkerOrderModel>>> getOrders(GetWorkerHomeParams params);
  Future<Either<Failure, String>> storeWorkerOffer(StoreWorkerOffersParams params);
  Future<Either<Failure, WorkerOrderDetailsModel>> getWorkerOrderDetails(
      WorkerOrderDetailsParams params);
}
