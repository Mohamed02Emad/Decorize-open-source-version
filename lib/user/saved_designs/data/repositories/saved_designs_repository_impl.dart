import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/saved_designs/data/datasources/saved_designs_datasource.dart';
import 'package:decorizer/user/saved_designs/domain/params/get_saved_designs_params.dart';
import 'package:decorizer/user/saved_designs/domain/repositories/saved_designs_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SavedDesignsRepository)
class SavedDesignsRepositoryImpl implements SavedDesignsRepository {
  final SavedDesignsDataSource remote;

  SavedDesignsRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ImageModel>>> getSavedDesigns(
      GetSavedDesignsParams params) async {
    return remote
        .getSavedDesigns(params)
        .mapError((json) => imagesFromJson(json['data']));
  }
}
