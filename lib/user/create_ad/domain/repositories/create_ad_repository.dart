import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_ad/domain/params/create_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/params/update_ad_params.dart';

abstract class CreateAdRepository {
  Future<Either<Failure, Unit>> createAd(CreateAdParams params);
  Future<Either<Failure, Unit>> updateAd(UpdateAdParams params);
}
