import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/failure.dart';
import '../models/static_page_response.dart';
import '../params/static_pages_params.dart';
import '../repositories/more_repository.dart';

@Injectable()
class GetStaticPageUseCase
    extends UseCase<StaticPageResponse, StaticPagesParams> {
  final MoreRepository repository;

  GetStaticPageUseCase(this.repository);

  @override
  Future<Either<Failure, StaticPageResponse>> call(StaticPagesParams params) {
    return repository.getStaticPages(params: params);
  }
}
