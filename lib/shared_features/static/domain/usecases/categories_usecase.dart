import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/shared_features/static/domain/repositories/static_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesUsecase extends UseCase<List<CategoryModel>, NoParams>{
  final StaticRepository repository;

  CategoriesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams params) async {
    return repository.getCategories();
  }
}
