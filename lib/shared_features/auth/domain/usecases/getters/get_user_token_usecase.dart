import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/local_repository.dart';

@Injectable()
class GetUserTokenUseCase extends UseCase<String?, NoParams> {
  final LocalRepository repository;

  GetUserTokenUseCase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    final token = repository.getUserAccessToken();
    return Right(token);
  }
}
