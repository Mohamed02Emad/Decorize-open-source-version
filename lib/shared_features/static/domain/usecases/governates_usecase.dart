import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/repositories/static_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GovernatesUsecase extends UseCase<List<GovernorateModel>, NoParams>{
  final StaticRepository repository;

  GovernatesUsecase(this.repository);

  @override
  Future<Either<Failure, List<GovernorateModel>>> call(NoParams params) async {
    return repository.getGovernorates();
  }
}
