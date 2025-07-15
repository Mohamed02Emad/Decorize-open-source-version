import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/params/open_design_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenDesignUsecase extends UseCase<Unit, OpenDesignParams>{
  final CreateDesignRepository repository;

  OpenDesignUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(OpenDesignParams params) async {
    return repository.openProject(params);
  }
}
