import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_ad/data/datasources/create_ad_remote_datasource.dart';
import 'package:decorizer/user/create_ad/domain/params/create_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/params/update_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/repositories/create_ad_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CreateAdRepository)
class CreateAdRepositoryImpl extends CreateAdRepository {
  final CreateAdRemoteDatasource remoteDatasource;
  CreateAdRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Unit>> createAd(CreateAdParams params) async {
    return remoteDatasource.createAd(params).mapError(
          (json) => unit,
        );
  }

  @override
  Future<Either<Failure, Unit>> updateAd(UpdateAdParams params) async {
    return remoteDatasource.updateAd(params).mapError(
          (json) => unit,
        );
  }
}
