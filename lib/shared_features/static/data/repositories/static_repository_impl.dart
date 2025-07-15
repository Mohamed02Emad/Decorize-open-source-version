import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/data/datasources/static_remote_datasource.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/shared_features/static/domain/params/get_cities_params.dart';
import 'package:decorizer/shared_features/static/domain/repositories/static_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: StaticRepository)
class StaticRepositoryImpl extends StaticRepository {
  final StaticRemoteDataSource remote;

  StaticRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates() async {
    return remote.getGovernorates().mapError(
          (json) => governoratesFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, List<CityModel>>> getCities(GetCitiesParams params) async {
    return remote.getCities(params).mapError(
          (json) => citiesFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, List<TypeModel>>> getTypes() async {
    return remote.getTypes().mapError(
          (json) => typesFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return remote.getCategories().mapError(
          (json) => categoriesFromJson(json['data']),
        );
  }
}
