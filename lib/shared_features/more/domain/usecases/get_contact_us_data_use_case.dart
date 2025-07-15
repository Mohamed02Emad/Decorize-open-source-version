import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/failure.dart';
import '../repositories/contact_us_repository.dart';

@Injectable()
class GetContactUsDataUseCase extends UseCase<Unit, NoParams> {
  final ContactUsRepository repository;

  GetContactUsDataUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.getContactUsData();
  }
}
