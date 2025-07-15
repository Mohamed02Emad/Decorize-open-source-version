import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/worker/offers/data/worker_offers_urls.dart';
import 'package:decorizer/worker/offers/domain/params/worker_offers_params.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/delete_worker_offer_params.dart';

abstract class WorkerOffersRemoteDataSource {
  DatasourceResult getOffers(GetWorkerOffersParams params);
  DatasourceResult deleteWorkerOffer(DeleteWorkerOfferParams params);
}

@Injectable(as: WorkerOffersRemoteDataSource)
class WorkerOffersRemoteDataSourceImpl implements WorkerOffersRemoteDataSource {
  final ApiBaseHelper apiHelper;
  WorkerOffersRemoteDataSourceImpl({required this.apiHelper});

  @override
  DatasourceResult getOffers(GetWorkerOffersParams params) {
    return apiHelper.get(url: WorkerOffersUrls.getOffers, queryParameters: params.toJson());
  }

  @override
  DatasourceResult deleteWorkerOffer(DeleteWorkerOfferParams params) {
    return apiHelper.delete(url: WorkerOffersUrls.deleteOffer(params.postId));
  }
}
