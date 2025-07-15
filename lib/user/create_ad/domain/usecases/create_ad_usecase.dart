import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_ad/domain/params/create_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/repositories/create_ad_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateAdUsecase extends UseCase<Unit, CreateAdParams>{
  final CreateAdRepository repository;
  CreateAdUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateAdParams params) async {
    return repository.createAd(params);
  }
}
