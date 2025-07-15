import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/worker/profile/domain/models/worker_profile_model.dart';
import 'package:decorizer/worker/profile/domain/params/get_worker_profile_params.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/worker_profile_repository.dart';
import '../datasources/worker_profile_remote_datasource.dart';

@Injectable(as: WorkerProfileRepository)
class WorkerProfileRepositoryImp implements WorkerProfileRepository {
  final WorkerProfileRemoteDataSource _workerProfileDataSource;

  WorkerProfileRepositoryImp(this._workerProfileDataSource);

  @override
  Future<Either<Failure,WorkerProfileModel>> getProfile(GetWorkerProfileParams params) async {
    return await _workerProfileDataSource.getProfile(params).mapError((json) => WorkerProfileModel.fromJson(json['data']));
  }
}