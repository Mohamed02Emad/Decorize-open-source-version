import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/local_repository.dart';

@Injectable()
class SetUserTokenUseCase extends UseCase<Unit, String?> {
  final LocalRepository repository;

  SetUserTokenUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String? params) async {
    repository.setUserAccessToken(params);
    return const Right(unit);
  }
}

