import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/util/get_file/picker_file_type.dart';
import 'package:decorizer/common/widget/app/multi_image_selection_widget.dart';
import 'package:decorizer/common/widget/form_to_box_adapter.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/create_ad/create_ad_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickDesignSection extends StatelessWidget {
  const PickDesignSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateAdCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(LocaleKeys.create_ad_add_image),
          style: TextStyles.semiBold12(context: context),
        ),
        Height(6.h),
        ValueListenableBuilder(
          valueListenable: cubit.pickedImages,
          builder: (context, pickedImages, child) => FormToBoxAdapter(
            value: pickedImages,
            validator: (value) => pickedImages?.isEmpty ?? true
                ? context.tr(LocaleKeys.validation_empty_images)
                : null,
            child: Container(
                height: 110.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: context.appColors.hintText.withValues(alpha: 0.4),
                      width: 0.4.w,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.isDarkMode ? context.appColors.onBackground : Colors.white),
                child: pickedImages != null && pickedImages.isNotEmpty
                    ? MultiImageSelectionWidget(
                        images: pickedImages,
                        maxSize: 5,
                        filesType: PickerFileType.image,
                        onRemoveImage: (index) =>
                            _onRemoveImage(context, index),
                        onAddImages: (files) => _onAddImages(context, files))
                    : Center(
                        child: SvgPicture.asset(
                          height: 23.h,
                          width: 23.w,
                          AppSvgs.pickImage,
                          fit: BoxFit.contain,
                        ),
                      ).clickable(
                        () => _pickImageFromGallery(context),
                      )),
          ),
        ),
      ],
    );
  }

  Future _pickImageFromGallery(BuildContext context) async {
    final cubit = context.read<CreateAdCubit>();
    final returnedImages =
        await PickFileUtil.showSelectMultiFileSourceBottomSheet(context,
            fileType: PickerFileType.image);
    cubit.pickedImages.value = returnedImages?.take(5).toList();
  }

  void _onRemoveImage(BuildContext context, int index) {
    final cubit = context.read<CreateAdCubit>();

    cubit.pickedImages.value = cubit.pickedImages.value
        ?.where((element) => element != cubit.pickedImages.value?[index])
        .toList();
  }

  void _onAddImages(BuildContext context, List<File> files) {
    final cubit = context.read<CreateAdCubit>();

    cubit.pickedImages.value =
        <File>[...cubit.pickedImages.value ?? [], ...files].take(5).toList();
  }
}
