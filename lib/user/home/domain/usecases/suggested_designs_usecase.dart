import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';
import 'package:decorizer/user/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SuggestedDesignsUsecase extends UseCase<List<ImageModel>, SuggestedDesignsParams>{
  final HomeRepository repository;

  SuggestedDesignsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ImageModel>>> call(SuggestedDesignsParams params) async {
    return repository.getSuggestedDesigns(params);
  }
}
