import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/failure.dart';
import '../params/contact_us_params.dart';
import '../repositories/contact_us_repository.dart';

@Injectable()
class SendContactUsMessageUseCase
    extends UseCase<Unit, ContactUsParams> {
  final ContactUsRepository repository;

  SendContactUsMessageUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ContactUsParams params) {
    return repository.sendContactUsMessage(params: params);
  }
}
