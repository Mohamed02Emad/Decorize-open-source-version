import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/worker/profile/domain/models/worker_profile_model.dart';
import 'package:decorizer/worker/profile/domain/params/get_worker_profile_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/usecase.dart';
import '../repository/worker_profile_repository.dart';


@Injectable()
class GetWorkerProfileUseCase extends UseCase<WorkerProfileModel,GetWorkerProfileParams>{
  final WorkerProfileRepository _repository;

  GetWorkerProfileUseCase(this._repository);

  Future<Either<Failure ,WorkerProfileModel >> call(GetWorkerProfileParams params) async {
    return await _repository.getProfile(params);
  }
}