import 'dart:io';

import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';

class UploadAiImageParams {
  final File image;
  final String projectId;

  UploadAiImageParams({required this.image, required this.projectId});

  Future<Map<String, dynamic>> toJson() async {
    final compressedMultipart =
        await CompressUtil.compressImageToMultiPart(image);
    return {
      "file": compressedMultipart,
    };
  }

  Future<FormData> toFormData() async {
    final compressedMultipart =
        await CompressUtil.compressImageToMultiPart(image);
    final formData = FormData();
    if (compressedMultipart != null) {
      formData.files.add(MapEntry("file", compressedMultipart));
    }
    return formData;
  }
}
