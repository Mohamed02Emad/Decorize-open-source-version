import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSavedDesignsUsecase extends UseCase<List<ImageModel>, NoParams> {
  final HomeRepository _repository;

  GetSavedDesignsUsecase(this._repository);

  @override
  Future<Either<Failure, List<ImageModel>>> call(NoParams params) async {
    final data = await _repository.getSavedDesigns();
    return data;
  }
}
