import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/shared_features/static/domain/params/get_cities_params.dart';

abstract class StaticRepository{
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates();
  Future<Either<Failure, List<CityModel>>> getCities(GetCitiesParams params);
  Future<Either<Failure, List<TypeModel>>> getTypes();
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
