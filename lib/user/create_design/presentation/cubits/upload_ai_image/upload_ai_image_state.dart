part of 'upload_ai_image_cubit.dart';

class UploadAiImageState extends Equatable {
  final RequestState<UploadDesignModel> uploadAiImageState;

  UploadAiImageState.initial() : uploadAiImageState = RequestState.initial();
  const UploadAiImageState({required this.uploadAiImageState});

  UploadAiImageState copyWith({
    RequestState<UploadDesignModel>? uploadAiImageState,
  }) {
    return UploadAiImageState(
      uploadAiImageState: uploadAiImageState ?? this.uploadAiImageState,
    );
  }

  @override
  List<Object?> get props => [uploadAiImageState];
}
