import 'dart:math';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableNetworkImage extends StatelessWidget {
  final String imageUrl;

  const ZoomableNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        imageUrl,
      ),
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppErrorWidget(
              errorMessage: 'error'.tr(),
            ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }
}
