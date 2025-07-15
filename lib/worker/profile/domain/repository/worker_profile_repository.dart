import 'package:dartz/dartz.dart';
import '../../../../common/failure.dart';
import '../models/worker_profile_model.dart';
import '../params/get_worker_profile_params.dart';

abstract class WorkerProfileRepository {
  Future<Either<Failure, WorkerProfileModel>> getProfile(GetWorkerProfileParams params);
}