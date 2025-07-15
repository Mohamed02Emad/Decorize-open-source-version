import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/worker/home/data/home_urls.dart';
import 'package:decorizer/worker/home/domain/params/get_worker_home_params.dart';
import 'package:decorizer/worker/home/domain/params/store_worker_offer_params.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/get_worker_order_details_params.dart';

abstract class WorkerHomeRemoteDataSource {
  DatasourceResult getOrders(GetWorkerHomeParams params);
  DatasourceResult getWorkerOrderDetails(WorkerOrderDetailsParams params);
  DatasourceResult storeWorkerOffer(StoreWorkerOffersParams params);
}

@Injectable(as: WorkerHomeRemoteDataSource)
class WorkerHomeRemoteDataSourceImpl implements WorkerHomeRemoteDataSource {
  final ApiBaseHelper apiHelper;
  WorkerHomeRemoteDataSourceImpl({required this.apiHelper});

  @override
  DatasourceResult getOrders(GetWorkerHomeParams params) {
    return apiHelper.get(url: HomeUrls.getWorkerHome, queryParameters: params.toJson());
  }
  @override
  DatasourceResult getWorkerOrderDetails(WorkerOrderDetailsParams params) {
    return apiHelper.get(
        url: HomeUrls.getOrderById(params.id));
  }

  @override
  DatasourceResult storeWorkerOffer(StoreWorkerOffersParams params) {
    return apiHelper.post(url: HomeUrls.storeWorkerOffer, body: params.toJson(),);
  }
}
