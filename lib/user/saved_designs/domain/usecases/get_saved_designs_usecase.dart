import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/saved_designs/domain/params/get_saved_designs_params.dart';
import 'package:decorizer/user/saved_designs/domain/repositories/saved_designs_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSavedDesignsUsecase
    extends UseCase<List<ImageModel>, GetSavedDesignsParams> {
  final SavedDesignsRepository repository;

  GetSavedDesignsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ImageModel>>> call(
      GetSavedDesignsParams params) async {
    return repository.getSavedDesigns(params);
  }
}
