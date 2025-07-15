import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/saved_designs/domain/params/get_saved_designs_params.dart';

abstract class SavedDesignsRepository {
  Future<Either<Failure, List<ImageModel>>> getSavedDesigns(
      GetSavedDesignsParams params);
}
