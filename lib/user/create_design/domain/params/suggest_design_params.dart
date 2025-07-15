import 'dart:io';
import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';

class SuggestDesignParams {
  final String projectId;
  final File image;
  final String promptArabic;
  final bool isRecreate;
  final String? fileId;

  SuggestDesignParams({
    required this.projectId,
    required this.image,
    required this.promptArabic,
    required this.isRecreate,
    this.fileId,
  });

  Future<FormData> toFormData() async {
    final content =
        'صورة فوتوغرافية لغرفة، تصميم داخلي، بدقة 4K، عالية الوضوح $promptArabic';
    final promptKey = isRecreate ? 'new_prompt_arabic' : 'prompt_arabic';
    final formData = FormData.fromMap({
      promptKey: content,
      if (fileId != null) 'image_id': fileId,
    });
    if (!isRecreate) {
      final compressedMultipart =
          await CompressUtil.compressImageToMultiPart(image);
      if (compressedMultipart != null) {
        formData.files.add(MapEntry("image", compressedMultipart));
      }
    }
    return formData;
  }
}
