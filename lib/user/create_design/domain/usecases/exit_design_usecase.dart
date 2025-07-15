import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/params/exit_design_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExitDesignUsecase extends UseCase<Unit, ExitDesignParams>{
  final CreateDesignRepository repository;

  ExitDesignUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ExitDesignParams params) async {
    return repository.exitProject(params);
  }
}
