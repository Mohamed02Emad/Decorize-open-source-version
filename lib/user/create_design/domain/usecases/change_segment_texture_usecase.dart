import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_texture_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeSegmentTextureUsecase extends UseCase<String, ChangeSegmentTextureParams>{
  final CreateDesignRepository repository;

  ChangeSegmentTextureUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(ChangeSegmentTextureParams params) async {
    return repository.changeTexture(params);
  }
}
