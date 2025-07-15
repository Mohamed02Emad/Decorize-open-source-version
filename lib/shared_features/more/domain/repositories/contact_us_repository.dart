import 'package:dartz/dartz.dart';

import '../../../../common/failure.dart';
import '../params/contact_us_params.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, Unit>> getContactUsData();
  Future<Either<Failure, Unit>> sendContactUsMessage(
      {required ContactUsParams params});
}
