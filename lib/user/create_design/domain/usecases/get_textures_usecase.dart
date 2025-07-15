import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/texture_model.dart';
import 'package:decorizer/user/create_design/domain/params/get_textures_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTexturesUsecase
    extends UseCase<List<TextureModel>, GetTexturesParams> {
  final CreateDesignRepository repository;

  GetTexturesUsecase(this.repository);

  @override
  Future<Either<Failure, List<TextureModel>>> call(
      GetTexturesParams params) async {
    return repository.getTextures(params);
  }
}
