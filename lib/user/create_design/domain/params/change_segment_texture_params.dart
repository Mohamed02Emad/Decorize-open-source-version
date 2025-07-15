import 'dart:io';

import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';

class ChangeSegmentTextureParams {
  final String fileId;
  final String projectId;
  final String segmentId;
  final File? texture;

  ChangeSegmentTextureParams(
      {required this.fileId,
      required this.projectId,
      required this.segmentId,
      required this.texture});
  Future<FormData> toFormData() async {
    final compressedMultipart =
        await CompressUtil.compressImageToMultiPart(texture);
    final formData = FormData.fromMap({
      "file_id": fileId,
      "segment_id": segmentId,
    });
    formData.files.add(MapEntry("texture_img", compressedMultipart!));
    return formData;
  }
}
