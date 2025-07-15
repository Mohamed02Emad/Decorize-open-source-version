import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/gen/locale_keys.g.dart';
import '../picker_file_type.dart';

class SelectFileSource extends StatelessWidget {
  final Function onCameraClicked;
  final Function onGalleryClicked;
  final Function onPdfClicked;
  final PickerFileType fileType;
  final bool isProfileImage;

  const SelectFileSource({
    super.key,
    required this.isProfileImage,
    required this.onCameraClicked,
    required this.onGalleryClicked,
    required this.onPdfClicked,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fileType == PickerFileType.file ? 270.h : 220.h,
      decoration: BoxDecoration(
        color: context.appColors.onBackground,
        borderRadius: BorderRadius.circular(20.h),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          if (fileType == PickerFileType.file)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.appColors.onBackground,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.picture_as_pdf),
                    SizedBox(
                      width: 10,
                    ),
                    Text('pdf'),
                  ],
                ),
              ).clickable(
                () {
                  onPdfClicked();
                  Nav.pop(context);
                },
                color: context.appColors.primary.withOpacity(0.15),
              ),
            ),
          if (fileType == PickerFileType.file)
            SizedBox(
              height: 20.h,
            ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.appColors.onBackground),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.image.svg.camera.path, width: 24, height: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('camera'.tr()),
                ],
              ),
            ).clickable(
              () {
                onCameraClicked();
                Nav.pop(context);
              },
              color: context.appColors.primary.withOpacity(0.15),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.appColors.onBackground),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.image.svg.gallery.path, width: 24, height: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('gallery'.tr()),
                ],
              ),
            ).clickable(
              () {
                onGalleryClicked();
                Nav.pop(context);
              },
              color: context.appColors.primary.withOpacity(0.15),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ).withTitle(
          title: context.tr(LocaleKeys.common_choose_image_source),
          centerTitle: true),
    );
  }
}
