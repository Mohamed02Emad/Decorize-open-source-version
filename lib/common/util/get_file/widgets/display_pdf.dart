import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DisplayPdf extends StatelessWidget {
  final String title;
  final File? file;

  const DisplayPdf({super.key, this.file, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: file != null
              ? PDFView(
                  filePath: file!.path,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: false,
                  onRender: (int? _pages) {},
                  onError: (error) {},
                  onPageError: (int? page, error) {},
                  onViewCreated: (PDFViewController pdfViewController) {},
                  onPageChanged: (int? page, int? total) {},
                )
              : AppErrorWidget(errorMessage: 'error'.tr())),
    );
  }
}
