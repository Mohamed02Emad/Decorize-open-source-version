import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/worker_order_details_model.dart';
import '../params/get_worker_order_details_params.dart';
import '../repository/worker_home_repository.dart';

@Injectable()
class WorkerOrderDetailsUsecase extends UseCase<WorkerOrderDetailsModel, WorkerOrderDetailsParams> {
  final WorkerHomeRepository workerHomeRepository;

  WorkerOrderDetailsUsecase({required this.workerHomeRepository});

  @override
  Future<Either<Failure, WorkerOrderDetailsModel>> call(WorkerOrderDetailsParams params) async {
    return workerHomeRepository.getWorkerOrderDetails(params);
  }
}