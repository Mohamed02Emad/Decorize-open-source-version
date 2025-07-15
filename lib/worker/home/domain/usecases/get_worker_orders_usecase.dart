import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/worker/home/domain/models/worker_order_model.dart';
import 'package:decorizer/worker/home/domain/params/get_worker_home_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/usecase.dart';
import '../repository/worker_home_repository.dart';


@Injectable()
class   GetWorkerOrdersUseCase extends UseCase<List<WorkerOrderModel>,GetWorkerHomeParams> {

   GetWorkerOrdersUseCase({required this.workerHomeRepository,});
  final WorkerHomeRepository workerHomeRepository;

@override
  Future<Either<Failure , List<WorkerOrderModel>>> call(GetWorkerHomeParams params) async {
    return workerHomeRepository.getOrders(params);
  }
}
