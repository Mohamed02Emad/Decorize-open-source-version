import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/suggest_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/suggest_design_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SuggestDesignUsecase
    extends UseCase<SuggestDesignModel, SuggestDesignParams> {
  final CreateDesignRepository _repository;

  SuggestDesignUsecase(this._repository);

  @override
  Future<Either<Failure, SuggestDesignModel>> call(SuggestDesignParams params) {
    return _repository.suggestDesign(params);
  }
}
