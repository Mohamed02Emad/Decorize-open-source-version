import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/util/get_file/picker_file_type.dart';
import 'package:decorizer/common/util/get_file/widgets/display_pdf.dart';
import 'package:decorizer/common/util/get_file/widgets/image_preview.dart';
import 'package:decorizer/common/util/get_file/widgets/select_file_bottom_sheet.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:nav/nav.dart';
import 'package:path/path.dart' as path;


class PickFileUtil {
  static Future<XFile?> pickImage({
    required BuildContext context,
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickerFile = await picker.pickImage(source: imageSource);
    if (pickerFile != null) {
      return pickerFile;
    } else {
      return null;
    }
  }

  static File? getFileFromXFile(XFile xFile) => File(xFile.path);

  static Future<String?> getImageUri(XFile file) async {
    try {
      File imageFile = File(file.path);
      return imageFile.uri.toString();
    } catch (e) {
      return null;
    }
  }


  static String getFileName(String? url, File? file) {
    if (isPdf(file: file)) {
      return _getPdfName(pdfUrl: url, pdfFile: file);
    }
    return _getImageName(imageFile: file, imageUrl: url);
  }

  static String _getPdfName({String? pdfUrl, File? pdfFile}) {
    if (pdfFile != null) {
      return path.basename(pdfFile.path);
    } else if (pdfUrl != null) {
      return pdfUrl.split('/').last;
    } else {
      return 'pdf';
    }
  }

  static String _getImageName({String? imageUrl, File? imageFile}) {
    if (imageFile != null) {
      return path.basename(imageFile.path);
    } else if (imageUrl != null) {
      return imageUrl.split('/').last;
    } else {
      return 'image';
    }
  }

  static void showFileSelected({String? url, File? file , String? heroTag}) {
    if (isPdf(file: file, url: url)) {
      if (file == null && url != null) {
        // openWebIntent(url: url);
        showErrorToast('افتكر تفعل اللينك');
        return;
      }
      Nav.push(
        DisplayPdf(
          file: file,
          title: _getPdfName(pdfUrl: url, pdfFile: file),
        ),
      );
    } else {
      Nav.push(
        ImagePreviewScreen(
          imageName: _getImageName(imageUrl: url, imageFile: file),
          localImagePath: file?.path,
          url: url,
          heroTag: heroTag,
        ),
      );
    }
  }

  static Future<List<File>?> showSelectMultiFileSourceBottomSheet(
      BuildContext context,
      {PickerFileType fileType = PickerFileType.image}) async {
    Completer<List<File>?> completer = Completer<List<File>?>();

    showModalBottomSheet<List<File>>(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      elevation: 20,
      backgroundColor: context.appColors.background,
      context: context,
      builder: (BuildContext context) {
        return SelectFileSource(
          isProfileImage: true,
          fileType: fileType,
          onCameraClicked: () async {
            final List<XFile>? imageXFiles = await ImagePicker().pickMultiImage();
            if (imageXFiles != null && imageXFiles.isNotEmpty) {
              completer.complete(imageXFiles.map((xFile) => File(xFile.path)).toList());
            } else {
              completer.complete(null);
            }
          },
          onGalleryClicked: () async {
            final List<XFile>? imageXFiles = await ImagePicker().pickMultiImage();
            if (imageXFiles != null && imageXFiles.isNotEmpty) {
              completer.complete(imageXFiles.map((xFile) => File(xFile.path)).toList());
            } else {
              completer.complete(null);
            }
          },
          onPdfClicked: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: <String>['pdf'],
              allowMultiple: true,
            );
            if (result != null) {
              List<File> files = result.files.map((file) => File(file.path!)).toList();
              completer.complete(files);
            } else {
              completer.complete(null);
            }
          },
        );
      },
    );
    return completer.future;
  }

  static Future<File?> showSelectFileSourceBottomSheet(BuildContext context,
      {PickerFileType fileType = PickerFileType.image}) async {
    Completer<File?> completer = Completer<File?>();

    showModalBottomSheet<File>(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      elevation: 20,
      backgroundColor: context.appColors.background,
      context: context,
      builder: (BuildContext context) {
        return SelectFileSource(
          isProfileImage: true,
          fileType: fileType,
          onCameraClicked: () async {
            final XFile? imageXFile = await PickFileUtil.pickImage(
                context: context, imageSource: ImageSource.camera);
            if (imageXFile != null) {
              completer.complete(PickFileUtil.getFileFromXFile(imageXFile));
            } else {
              completer.complete(null);
            }
          },
          onGalleryClicked: () async {
            final XFile? imageXFile = await PickFileUtil.pickImage(
                context: context, imageSource: ImageSource.gallery);
            if (imageXFile != null) {
              completer.complete(PickFileUtil.getFileFromXFile(imageXFile));
            } else {
              completer.complete(null);
            }
          },
          onPdfClicked: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: <String>['pdf'],
            );
            if (result != null) {
              File file = File(result.files.single.path!);
              completer.complete(file);
            } else {
              completer.complete(null);
            }
          },
        );
      },
    );
    return completer.future;
  }

  static Future<File> changeImageQuality(File inputFile,
      {int quality = 60}) async {
    Uint8List imageBytes = await inputFile.readAsBytes();
    img.Image originalImage = img.decodeImage(Uint8List.fromList(imageBytes))!;

    List<int> resizedBytes = img.encodeJpg(originalImage, quality: quality);

    final Directory tempDir = Directory.systemTemp;
    final String tempPath =
        '${tempDir.path}/${_getImageName(imageUrl: null, imageFile: inputFile)}';
    final File tempFile = File(tempPath);

    await tempFile.writeAsBytes(resizedBytes);
    return tempFile;
  }

  static bool isPdf({File? file, String? url}) {
    if (file != null) {
      String extension = file.path.split('.').last.toLowerCase();
      return extension == 'pdf';
    } else if (url != null) {
      return url.contains('.pdf');
    }
    return false;
  }

  static Future<File> resizeFile(File inputFile) async {
    if (isPdf(file: inputFile)) {
      return inputFile;
    }
    return resizeImageInBackground(inputFile);
  }

  static Future<File> _resizeFileLogic(File inputFile) async {
    try {
      final imageBytes = await inputFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        throw Exception('Unable to decode image');
      }

      int quality = 100;
      List<int> compressedBytes = img.encodeJpg(image, quality: quality);

      while (_isFileSizeExceeded(compressedBytes) && quality > 10) {
        quality -= 10;
        compressedBytes = img.encodeJpg(image, quality: quality);
      }

      final compressedFile = File(_getCompressedFilePath(inputFile.path));
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      throw Exception('Failed to resize image: $e');
    }
  }

  static bool _isFileSizeExceeded(List<int> bytes) {
    return bytes.length / 1024 > 800;
  }

  static String _getCompressedFilePath(String originalPath) {
    final fileExtension = originalPath.split('.').last;
    return originalPath.replaceFirst(
        '.$fileExtension', '_compressed.$fileExtension');
  }

  static Future<File> resizeImageInBackground(File inputFile) async {
    final ReceivePort resultPort = ReceivePort();

    try {
      await _crateIsolate(resultPort, inputFile);
    } catch (e) {
      throw Exception();
    }

    final response = await resultPort.first;

    if (response == null) {
      throw Exception();
    } else if (response is List) {
      final errorAsString = response[0];
      throw Exception(errorAsString);
    } else {
      resultPort.close();
      return response as File;
    }
  }

  static Future<void> _crateIsolate(
      ReceivePort resultPort, File imageFile) async {
    RootIsolateToken rootToken = RootIsolateToken.instance!;
    await Isolate.spawn(
      _compress,
      <Object>[resultPort.sendPort, imageFile, rootToken],
      errorsAreFatal: true,
      onExit: resultPort.sendPort,
      onError: resultPort.sendPort,
    );
  }

  static Future<void> _compress(List<dynamic> args) async {
    final imageFile = args[1];
    SendPort resultPort = args[0];
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[2]);
    try {
      final File resizedImage = await _resizeFileLogic(imageFile);
      Isolate.exit(resultPort, resizedImage);
    } catch (e) {
      throw Exception();
    }
  }
}
