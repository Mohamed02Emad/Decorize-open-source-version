import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/failure.dart';
import '../repositories/more_repository.dart';

@Injectable()
class DeleteAccountUseCase extends UseCase<Unit, NoParams> {
  final MoreRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.deleteAccount();
  }
}
