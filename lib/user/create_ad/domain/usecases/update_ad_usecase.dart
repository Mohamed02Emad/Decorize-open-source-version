import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_ad/domain/params/update_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/repositories/create_ad_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UpdateAdUsecase extends UseCase<Unit, UpdateAdParams> {
  final CreateAdRepository repository;
  UpdateAdUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateAdParams params) async {
    return repository.updateAd(params);
  }
}
