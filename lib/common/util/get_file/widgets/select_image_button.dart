import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/get_file/picker_file_type.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_svgs.dart';
import '../../../widget/dashed_container.dart';
import '../pick_file_util.dart';
import 'custom_image.dart';

enum _SelectFileButtonType {
  dashed,
  roundedImage;
}

class SelectFileButton extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final Size? imageSize;
  final Function(File?) onImageSelected;
  late final _SelectFileButtonType _buttonType;
  late bool canEditImage;

  SelectFileButton.dashed({
    super.key,
    required this.imageFile,
    this.imageUrl,
    required this.onImageSelected,
    this.imageSize,
  }) {
    _buttonType = _SelectFileButtonType.dashed;
  }

  SelectFileButton.roundedImage({
    super.key,
    required this.imageFile,
    this.imageUrl,
    required this.onImageSelected,
    this.imageSize,
    this.canEditImage = true,
  }) {
    _buttonType = _SelectFileButtonType.roundedImage;
  }

  @override
  Widget build(BuildContext context) {
    return switch (_buttonType) {
      _SelectFileButtonType.dashed => _buildDashedField(context),
      _SelectFileButtonType.roundedImage => _buildRoundedField(context),
    };
  }

  void _selectFile(BuildContext context) async {
    final File? file = await PickFileUtil.showSelectFileSourceBottomSheet(
        context,
        fileType: PickerFileType.image);
    if (file != null) {
      onImageSelected(file);
    }
  }

  Widget _buildDashedField(BuildContext context) =>
      imageFile == null && imageUrl == null
          ? DashedContainer(
              onClick: () {
                _selectFile(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Center(
                      child: SvgPicture.asset(
                        AppSvgs.upload,
                        width: 30.h,
                        height: 30.h,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : CustomImage(
              url: imageUrl,
              file: imageFile,
              onRemove: () => onImageSelected(null),
              onEdit: () {
                _selectFile(context);
              },
              size: imageSize?.height ?? 100.h,
            );

  Widget _buildRoundedField(BuildContext context) {
    final size = imageSize?.height ?? 100.h;
    final radius = size / 2;
    return imageFile == null && imageUrl == null
        ? Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: context.appColors.onBackground,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(width: 1.0, color: context.appColors.text),
            ),
            child: Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: size / 2,
              ),
            ),
          ).clickable(() => _selectFile(context), radius: radius)
        : Stack(
            children: [
              AppImage(
                path: imageUrl ?? '',
                file: imageFile,
                radius: radius,
                width: size,
                height: size,
              ).clickable(
                () => _selectFile(context),
                radius: radius,
              ),
              PositionedDirectional(
                bottom: 0,
                end: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: 34.w.borderRadius,
                    border: Border.all(color: AppColors.goldenOrange, width: 0.8.h),
                    color: context.appColors.onBackground,
                  ),
                  width: 35.w,
                  height: 35.w,
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      size: 18.h,
                      color: AppColors.goldenOrange,
                    ),
                  ),
                ).clickable(
                  () => onImageSelected(null),
                radius: 35.w),
              ),
            ],
          );
  }
}
