import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_design/domain/models/upload_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/upload_ai_image_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/upload_ai_image_usecase.dart';
import 'package:decorizer/user/create_design/presentation/cubits/upload_ai_image/upload_ai_image_cubit_variables.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'upload_ai_image_state.dart';

@Injectable()
class UploadAiImageCubit extends BaseCubit<UploadAiImageState>
    with UploadAiImageCubitVariables {
  final UploadAiImageUsecase uploadAiImageUsecase;

  UploadAiImageCubit(this.uploadAiImageUsecase)
      : super(UploadAiImageState.initial());

  Future<void> uploadAiImage() async {
    if (state.uploadAiImageState.isLoading) return;

    final params = UploadAiImageParams(
      projectId: projectId,
      image: image,
    );

    callAndFold(
      future: uploadAiImageUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(uploadAiImageState: requestState)),
    );
  }
}
