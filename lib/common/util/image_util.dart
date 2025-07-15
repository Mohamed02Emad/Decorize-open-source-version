import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtil {
  ImageUtil._();

  static Future<String?> saveUnitListImageToGallery(
      Uint8List imageBytes) async {
    try {
      final permission = await _requestStoragePermission();
      if (!permission) {
        return 'Storage permission denied';
      }
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: 'image_${DateTime.now().millisecondsSinceEpoch}',
      );
      if (result['isSuccess'] == true) {
        return null; // Success
      } else {
        return result['errorMessage'] ?? 'Failed to save image';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveImageToGallery(String imageUrl) async {
    try {
      // Request storage permission
      final permission = await _requestStoragePermission();
      if (!permission) {
        return 'Storage permission denied';
      }

      final imageBytes = await downloadImage(imageUrl);
      if (imageBytes == null) {
        return 'Failed to download image';
      }

      // Save to gallery using image_gallery_saver
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: 'image_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (result['isSuccess'] == true) {
        return null; // Success
      } else {
        return result['errorMessage'] ?? 'Failed to save image';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Use storage permissions for all Android versions
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isDenied) {
        final photosStatus = await Permission.photos.request();
        return photosStatus.isGranted;
      }
      return storageStatus.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> _isAndroid13OrHigher() async {
    if (Platform.isAndroid) {
      try {
        // This is a simple check - in a real app you might want to use device_info_plus
        // For now, we'll assume newer devices have the photos permission
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  static Future<Uint8List?> downloadImage(String imageUrl) async {
    // Download the image
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      return null;
    }

    final imageBytes = response.bodyBytes;
    return imageBytes;
  }

  static Future<File?> downloadImageToFile(String imageUrl) async {
    final imageBytes = await downloadImage(imageUrl);
    if (imageBytes == null) {
      return null;
    }
    return File.fromRawPath(imageBytes);
  }
}
