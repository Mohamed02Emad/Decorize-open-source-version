import 'dart:io';
import 'package:decorizer/common/util/compress_util.dart';
import 'package:dio/dio.dart';

class UpdateProfileParams {
  final String name;
  final String email;
  final String phone;
  final String? password;
  final File? profileImage;

  UpdateProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.profileImage,
  });

  Future<FormData> toFormData() async {
    final  data = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      if (password != null && password!.isNotEmpty) 'password': password,
    });

    if (profileImage != null) {
      final MultipartFile? compressedImage =
          await CompressUtil.compressImageToMultiPart(profileImage);
      if (compressedImage != null) {
        data.files.add(MapEntry('image', compressedImage));
      }
    }

    return data;
  }
}
