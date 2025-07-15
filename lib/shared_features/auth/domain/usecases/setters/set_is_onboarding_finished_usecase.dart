import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/local_repository.dart';

@Injectable()
class SetIsOnboardingFinishedUseCase extends UseCase<Unit, bool> {
  final LocalRepository repository;

  SetIsOnboardingFinishedUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(bool params) async {
    repository.setFinishedOnBoarding(params);
    return const Right(unit);
  }
}
