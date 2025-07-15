import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/util/get_file/picker_file_type.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/user/create_design/domain/models/texture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentTextureWidget extends StatelessWidget {
  final String title;
  final File? localTexture;
  final TextureModel? selectedTexture;
  final List<TextureModel> availableTextures;
  final Function(File?) onLocalTextureSelected;
  final Function(TextureModel?) onTextureSelected;
  final Function() onClearTexture;

  const SegmentTextureWidget({
    super.key,
    required this.title,
    this.localTexture,
    this.selectedTexture,
    required this.availableTextures,
    required this.onLocalTextureSelected,
    required this.onTextureSelected,
    required this.onClearTexture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.appColors.onBackground,
        borderRadius: BorderRadius.circular(8.r),
        border:
            Border.all(color: context.appColors.grey_2.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          // Title
          Text(
            title,
            style: TextStyles.semiBold12(),
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(width: 12.w),

          // Current texture preview
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: context.appColors.grey_2),
              color: context.appColors.background,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: (localTexture != null || selectedTexture != null)
                  ? Stack(
                      children: [
                        if (localTexture != null)
                          AppImage(
                            path: null,
                            file: localTexture,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          )
                        else if (selectedTexture != null)
                          AppImage(
                            path: selectedTexture!.image,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                        Positioned(
                          top: 2.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: onClearTexture,
                            child: Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Icon(
                      Icons.texture,
                      color: context.appColors.grey_2,
                      size: 20.h,
                    ),
            ),
          ),

          SizedBox(width: 12.w),

          // Upload from phone button
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 35.h,
              child: ElevatedButton(
                onPressed: () => _selectFromPhone(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.create_design_phone.tr(),
                  style: TextStyles.semiBold12().copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Dropdown for URL selection
          Expanded(
            flex: 4,
            child: Container(
              height: 35.h,
              decoration: BoxDecoration(
                border: Border.all(color: context.appColors.grey_2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TextureModel>(
                  isExpanded: true,
                  value: selectedTexture,
                  hint: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      LocaleKeys.create_design_select_texture.tr(),
                      style: TextStyles.regular11(
                        color: context.appColors.hintText,
                      ),
                    ),
                  ),
                  items: [
                    // DropdownMenuItem<String>(
                    //   value: null,
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //     child: Text(
                    //       LocaleKeys.create_design_none.tr(),
                    //       style: TextStyles.regular11(),
                    //     ),
                    //   ),
                    // ),
                    ...availableTextures.map(
                      (texture) => DropdownMenuItem<TextureModel>(
                        value: texture,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 15.h,
                                margin: EdgeInsets.only(right: 6.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.r),
                                  border: Border.all(
                                    color: context.appColors.grey_2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3.r),
                                  child: AppImage(
                                    path: texture.image,
                                    width: 20.w,
                                    height: 15.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  texture.title,
                                  style: TextStyles.regular11(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (TextureModel? value) {
                    onTextureSelected(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectFromPhone(BuildContext context) async {
    final file = await PickFileUtil.showSelectFileSourceBottomSheet(
      context,
      fileType: PickerFileType.image,
    );
    if (file != null) {
      onLocalTextureSelected(file);
    }
  }
}
