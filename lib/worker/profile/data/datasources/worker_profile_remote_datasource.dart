import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/worker/profile/domain/params/get_worker_profile_params.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/util/api_basehelper.dart';
import '../worker_profile_urls.dart';

abstract class WorkerProfileRemoteDataSource {
  DatasourceResult getProfile(GetWorkerProfileParams params);
}

@Injectable(as: WorkerProfileRemoteDataSource)
class WorkerProfileRemoteDataSourceImpl implements WorkerProfileRemoteDataSource {
  final ApiBaseHelper apiHelper;
  WorkerProfileRemoteDataSourceImpl({required this.apiHelper});

  @override
  DatasourceResult getProfile(GetWorkerProfileParams params) {
    return apiHelper.get(url: WorkerProfileUrls.getProfile(),
      queryParameters: params.toJson(),);
  }
}