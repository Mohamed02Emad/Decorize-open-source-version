import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/home/data/dataSources/home_remote_datasource.dart';
import 'package:decorizer/user/home/domain/params/all_designs_params.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';
import 'package:decorizer/user/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ImageModel>>> getSuggestedDesigns(
      SuggestedDesignsParams params) async {
    return remote
        .getSuggestedDesigns(params)
        .mapError((json) => imagesFromJson(json['data']));
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getSavedDesigns() async {
    return remote
        .getSavedDesigns()
        .mapError((json) => imagesFromJson(json['data']));
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getAllDesigns(
      AllDesignsParams params) async {
    return remote
        .getAllDesigns(params)
        .mapError((json) => imagesFromJson(json['data']));
  }
}
