import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/params/get_cities_params.dart';
import 'package:decorizer/shared_features/static/domain/repositories/static_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CitiesUsecase extends UseCase<List<CityModel>, GetCitiesParams>{
  final StaticRepository repository;

  CitiesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CityModel>>> call(GetCitiesParams params) async {
    return repository.getCities(params);
  }
}
