import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CompressUtil {
  static Future<File?> compressImage(File? imageFile,
      {int quality = 80}) async {
    if (imageFile != null) {
      final filePath = imageFile.path;
      final ext = path.extension(filePath).toLowerCase();

      // Check if the file extension is a supported image format
      if (ext != '.jpg' &&
          ext != '.jpeg' &&
          ext != '.png' &&
          ext != '.gif' &&
          ext != '.webp') {
        throw Exception('Unsupported image format');
      }


      // Always output to JPEG
      final splitted = filePath.substring(0, filePath.lastIndexOf('.'));
      final outPath = '${splitted}_compressed.jpg';

      // Compress the image
      final result = await FlutterImageCompress.compressAndGetFile(
          imageFile.path, outPath,
          format: CompressFormat.jpeg, quality: quality);

      if (result == null) {
        throw Exception('Failed to compress image');
      }

      return File(result.path);
    }
    return null;
  }

  static Future<MultipartFile?> compressImageToMultiPart(File? imageFile,
      {int quality = 90}) async {
    if (imageFile != null) {
      final result = await compressImage(imageFile, quality: quality ,);

      if (result == null) {
        throw Exception('Failed to compress image');
      }

      final MultipartFile image = await MultipartFile.fromFile(result.path,
          filename: path.basename(result.path),
          contentType: DioMediaType.parse('image/jpeg')
          );
      return image;
    }
    return null;
  }

  static Future<List<File>> compressListOfImages(List<File> images) async {
    List<File> compressedImages = [];
    for (File image in images) {
      final compressedImage = await compressImage(image);
      if (compressedImage != null) {
        compressedImages.add(compressedImage);
      }
    }
    return compressedImages;
  }

  static Future<List<MultipartFile>> compressListOfImagesToMultiPart(
      List<File> images) async {
    List<MultipartFile> compressedImages = [];
    for (File image in images) {
      final compressedImage = await compressImageToMultiPart(image);
      if (compressedImage != null) {
        compressedImages.add(compressedImage);
      }
    }
    return compressedImages;
  }

  static Future<List<File>> compressListOfXFileImages(
      List<XFile> images) async {
    List<File> compressedImages = [];
    final fileImages = images.map((e) => File(e.path));
    for (File image in fileImages) {
      final compressedImage = await compressImage(image);
      if (compressedImage != null) {
        compressedImages.add(compressedImage);
      }
    }
    return compressedImages;
  }
}
