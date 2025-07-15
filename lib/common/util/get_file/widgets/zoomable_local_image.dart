import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableLocalImage extends StatelessWidget {
  final String imagePath;

  const ZoomableLocalImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FileImage(
        File(imagePath),
      ),
    );
  }
}
