import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_constants.dart';

class RoundedImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double? size;
  final Color? borderColor;
  final bool enableClick;
  final Function()? onClick;

  const RoundedImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.size,
    this.borderColor,
    this.onClick,
    this.enableClick = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.mainCorner),
      child: Container(
        width: size ?? 160.h,
        height: size ?? 160.h,
        decoration: BoxDecoration(
          border:
              Border.all(width: 1.h, color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(AppConstants.mainCorner),
        ),
        child: imageFile != null
            ? GestureDetector(
                onTap: imageClicked,
                child: Image.file(
                  imageFile!,
                  width: size ?? 160.h,
                  height: size ?? 160.h,
                ),
              )
            : GestureDetector(
                onTap: imageClicked,
                child: Image.network(
                  imageUrl ?? 'show error widget',
                  width: size ?? 160.h,
                  height: size ?? 160.h,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return SvgPicture.asset(
                      AppSvgs.profile,
                      width: size ?? 160.h,
                      height: size ?? 160.h,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return AppLoading(
                      size: 30.h,
                    );
                  },
                ),
              ),
      ),
    );
  }

  void imageClicked() {
    if (enableClick.not()) return;
    if (onClick == null) {
      PickFileUtil.showFileSelected(file: imageFile);
    } else {
      onClick!();
    }
  }
}
