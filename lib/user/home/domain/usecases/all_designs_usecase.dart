import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/home/domain/params/all_designs_params.dart';
import 'package:decorizer/user/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllDesignsUsecase extends UseCase<List<ImageModel>, AllDesignsParams> {
  final HomeRepository repository;

  AllDesignsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ImageModel>>> call(
      AllDesignsParams params) async {
    return repository.getAllDesigns(params);
  }
}
