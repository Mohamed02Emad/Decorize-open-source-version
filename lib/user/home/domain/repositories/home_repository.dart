import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/home/domain/params/all_designs_params.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ImageModel>>> getSuggestedDesigns(
      SuggestedDesignsParams params);
  Future<Either<Failure, List<ImageModel>>> getSavedDesigns();
  Future<Either<Failure, List<ImageModel>>> getAllDesigns(
      AllDesignsParams params);
}
