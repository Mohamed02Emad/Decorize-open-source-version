import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/params/save_design_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveDesignUsecase extends UseCase<Unit, SaveDesignParams> {
  final CreateDesignRepository repository;

  SaveDesignUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SaveDesignParams params) async {
    return repository.saveProject(params);
  }
}
