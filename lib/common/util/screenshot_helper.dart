import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:decorizer/common/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ScreenShotHelper {
  static Future<Uint8List?> captureWidgetToPng(
    GlobalKey key, {
    bool saveToGallery = false,
  }) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      // Convert the render object to an image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Convert the image to a byte array in PNG format
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      if (saveToGallery) {
        await ImageUtil.saveUnitListImageToGallery(pngBytes);
      }
      return pngBytes;
    } catch (e) {
      return null;
    }
  }



  static Future<Uint8List?> readFileToUint8List(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      return bytes;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> writeUint8ListToTempFile(
    Uint8List? data, {
    String? fileName,
  }) async {
    if (data == null) return null;
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/${fileName ?? 'temp_file_replaceable'}.png';
      final file = File(filePath);
      await file.writeAsBytes(data);
      return file;
    } catch (_) {
      return null;
    }
  }
}
