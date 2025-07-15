import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/shared_features/static/domain/repositories/static_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TypesUsecase extends UseCase<List<TypeModel>, NoParams>{
  final StaticRepository repository;

  TypesUsecase(this.repository);

  @override
  Future<Either<Failure, List<TypeModel>>> call(NoParams params) async {
    return repository.getTypes();
  }
}
