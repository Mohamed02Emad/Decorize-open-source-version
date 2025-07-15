import 'dart:io';

import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant/app_svgs.dart';
import '../pick_file_util.dart';

class CustomImage extends StatelessWidget {
  final double? size , radius;
  final String? url;
  final File? file;
  final Function()? onClick, onEdit, onRemove;

  const CustomImage({
    super.key,
    this.size,
    this.radius,
    required this.url,
    this.file,
    this.onClick,
    this.onEdit,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size ?? 80.h,
          width: size ?? 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10.r)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10.r)),
            child: url != null
                ? Image.network(
                    url!,
                    height: size ?? 80.h,
                    width: size ?? 80.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return SvgPicture.asset(
                        AppSvgs.error,
                        width: (size ?? 80.h) / 2,
                        height: (size ?? 80.h) / 2,
                      );
                    },
                  )
                : file != null
                    ? Image.file(
                        file!,
                        height: size ?? 80.h,
                        width: size ?? 80.h,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return SvgPicture.asset(
                            AppSvgs.error,
                            width: (size ?? 80.h) / 2,
                            height: (size ?? 80.h) / 2,
                          );
                        },
                      )
                    : Center(
                        child: SvgPicture.asset(
                        AppSvgs.error,
                        width: (size ?? 80.h) / 2,
                        height: (size ?? 80.h) / 2,
                      )),
          ),
        ),
        if (onEdit != null)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: context.appColors.primary, width: 0.8.h),
                color: context.appColors.white.withOpacity(0.20),
              ),
              width: 33.w,
              height: 33.w,
              child: Icon(
                Icons.edit,
                size: 20.h,
                color: context.appColors.primary,
              ).clickable(onEdit!),
            ),
          ),
        if (onRemove != null)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: context.appColors.red, width: 0.8.h),
                color: context.appColors.white.withOpacity(0.20),
              ),
              width: 33.w,
              height: 33.w,
              child: Icon(
                Icons.delete,
                size: 20.h,
                color: context.appColors.red,
              ).clickable(onRemove!),
            ),
          )
      ],
    ).clickable(() {
      onClick == null
          ? PickFileUtil.showFileSelected(file: file, url: url)
          : onClick!();
    },);
  }
}
