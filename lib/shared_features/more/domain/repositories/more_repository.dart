import 'package:dartz/dartz.dart';

import '../../../../common/failure.dart';
import '../models/static_page_response.dart';
import '../params/static_pages_params.dart';

abstract class MoreRepository {
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> deleteAccount();
  Future<Either<Failure, StaticPageResponse>> getStaticPages({required StaticPagesParams params});
}
