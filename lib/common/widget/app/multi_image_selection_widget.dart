import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/widget/app/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_constants.dart';
import '../../util/get_file/picker_file_type.dart';
import '../spaces.dart';

class MultiImageSelectionWidget extends StatelessWidget {
  final List<File> images;
  final List<String>? imagesUrl;
  final String? title;
  final bool readOnly;
  final int? maxSize;
  final PickerFileType filesType;
  final ScrollController? controller;

  ///remove the index from the real list to rebuild this widget *
  final Function(int) onRemoveImage;

  ///add these images to the real list and rebuild the widget *
  final Function(List<File>) onAddImages;

  const MultiImageSelectionWidget(
      {super.key,
      required this.images,
      this.imagesUrl,
      required this.onRemoveImage,
      this.title,
      this.controller,
      this.maxSize,
      this.filesType = PickerFileType.file,
      required this.onAddImages,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    final length = readOnly
        ? imagesUrl?.length ?? 0
        : images.length == (maxSize ?? -1)
            ? images.length
            : images.length + 1;
    return Column(
      children: [
        if (title != null)
          Row(
            children: [
              Width(16.w),
              Text(
                title!,
                textAlign: TextAlign.start,
                style: TextStyles.semiBold16(),
              ),
            ],
          ),
        Height(8.h),
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            itemCount: length,
            itemBuilder: (ctx, index) => index ==
                    (readOnly ? imagesUrl : images.length)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: readOnly
                        ? Container()
                        : _AddImage(
                            onClick: () => getImage(context),
                          ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Stack(
                      children: [
                        RoundedImage(
                          size: 80.h,
                          imageUrl: readOnly ? imagesUrl![index] : null,
                          imageFile: readOnly ? null : images[index],
                          borderColor: context.appColors.primary,
                        ),
                        if (readOnly.not())
                          Positioned(
                            top: -6.w,
                            right: -6.w,
                            child: SvgPicture.asset(
                              AppSvgs.minus,
                              colorFilter: context.appColors.red.colorFilter,
                              width: 35.h,
                            ).clickable(() {
                              onRemoveImage(index);
                            }),
                          )
                      ],
                    ).clip(10.r),
                  ),
          ),
        )
      ],
    );
  }

  void getImage(BuildContext context) async {
    final images = await PickFileUtil.showSelectMultiFileSourceBottomSheet(context,
        fileType: filesType);
    if (images != null) {
      if(maxSize == null){
        onAddImages(images);
        return;
      }
      final currentCount = this.images.length;
      final remainingSlots = maxSize! - currentCount;
      final imagesToAdd = images.take(remainingSlots).toList();
      if (imagesToAdd.isNotEmpty) {
        onAddImages(imagesToAdd);
      }
    }
  }
}

class _AddImage extends StatelessWidget {
  final Function() onClick;

  const _AddImage({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 80.h,
        height: 80.h,
        decoration: BoxDecoration(
          color: context.appColors.primary.withOpacity(0.3),
          border: Border.all(width: 1.h, color: context.appColors.primary),
          borderRadius: BorderRadius.circular(AppConstants.mainCorner),
        ),
        child: Center(
            child: Icon(
          Icons.add,
          size: 50.h,
          color: context.appColors.primary,
        )),
      ),
    );
  }
}
