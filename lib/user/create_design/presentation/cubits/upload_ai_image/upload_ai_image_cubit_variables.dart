import 'dart:io';

mixin UploadAiImageCubitVariables {
  late final String projectId;
  late final File image;

  init({required String projectId, required File image}) {
    this.projectId = projectId;
    this.image = image;
  }
}
