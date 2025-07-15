import 'dart:io';

import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';

class SaveDesignParams {
  final String title;
  final File image;

  SaveDesignParams({required this.title, required this.image});

  Future<FormData> toFormData() async {
    final compressedImage = await CompressUtil.compressImageToMultiPart(image);
    final formData = FormData.fromMap({
      'title': title,
    });
    formData.files.add(MapEntry('image', compressedImage!));
    return formData;
  }
}
