import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/local_repository.dart';

@Injectable()
class GetIsOnboardingFinishedUseCase extends UseCase<bool, NoParams> {
  final LocalRepository repository;

  GetIsOnboardingFinishedUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final isOnboardingFinished = repository.finishedOnBoarding();
    return Right(isOnboardingFinished);
  }
}
