import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/upload_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/upload_ai_image_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadAiImageUsecase extends UseCase<UploadDesignModel, UploadAiImageParams>{
  final CreateDesignRepository repository;

  UploadAiImageUsecase(this.repository);

  @override
  Future<Either<Failure, UploadDesignModel>> call(UploadAiImageParams params) async {
    return repository.uploadImage(params);
  }
}
