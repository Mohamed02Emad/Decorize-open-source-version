import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/image_util.dart';
import 'package:decorizer/common/util/screenshot_helper.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/upload_ai_image/upload_ai_image_cubit.dart';
import 'package:decorizer/user/create_design/presentation/widgets/bottom_sheets/edit_segments_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class DesignYourselfBottomSection extends StatelessWidget {
  final DesignSegmentsModel segments;
  DesignYourselfBottomSection({super.key, required this.segments});

  final ValueNotifier<bool> isDownloading = ValueNotifier(false);
  final ValueNotifier<bool> isSharing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < -5) {
          _showEditSegmentsBottomSheet(context);
        }
      },
      onTap: () => _showEditSegmentsBottomSheet(context),
      child: Container(
        width: double.infinity,
        padding: 10.edgeInsetsVertical,
        margin: MediaQuery.of(context).padding.bottom.edgeInsetsBottom,
        decoration: BoxDecoration(
          color: context.appColors.onBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.12),
                borderRadius: 8.r.borderRadius,
              ),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: isSharing,
                  builder: (context, value, child) => value
                      ? AppLoading()
                      : SvgPicture.asset(Assets.image.svg.shareDesign.path,
                      colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : null,
                      ),
                ),
              ),
            ).clickable(
              () => _onShareClicked(context),
              color: context.appColors.primary,
            ),
            Container(
              margin: 8.edgeInsetsVertical,
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_up_outlined,
                      color: context.isDarkMode ? context.appColors.text : context.appColors.primary, size: 24),
                  4.gap,
                  Text(LocaleKeys.create_design_design_yourself.tr(),
                      style: TextStyles.semiBold14()),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color:  context.appColors.primary.withValues(alpha: 0.12),
                    borderRadius: 8.r.borderRadius,
                  ),
                  padding: 6.edgeInsetsAll,
                  child: Center(
                    child: SvgPicture.asset(Assets.image.svg.edit.path,
                    colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : null,
                    ),
                  ),
                ).clickable(
                  () => _showEditSegmentsBottomSheet(context),
                  color: context.appColors.primary,
                ),
                8.w.gap,
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.12),
                    borderRadius: 8.r.borderRadius,
                  ),
                  padding: 6.edgeInsetsAll,
                  child: ValueListenableBuilder(
                    valueListenable: isDownloading,
                    builder: (context, value, child) => Center(
                      child: value
                          ? AppLoading()
                          : SvgPicture.asset(Assets.image.svg.download.path,
                          colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : null,
                          ),
                    ),
                  ),
                ).clickable(
                  () => _onDownloadClicked(context),
                  color: context.appColors.primary,
                ),
              ],
            ),
          ],
        ).marginHorizontal(16.w),
      ),
    );
  }

  void _showEditSegmentsBottomSheet(BuildContext context) {
    final cubit = context.read<DesignSegmentsCubit>();
    final uploadAiCubit = context.read<UploadAiImageCubit>();

    EditSegmentsBottomsheet.show(
      context,
      projectId: uploadAiCubit.state.uploadAiImageState.data?.projectId ?? "",
      fileId: uploadAiCubit.state.uploadAiImageState.data?.fileId ?? "",
      onColorsSaved: (colorMap) async {
        // Handle color updates
        await cubit.updateSegmentsColors(
          projectId:
              uploadAiCubit.state.uploadAiImageState.data?.projectId ?? "",
          segmentIds: cubit.segmentsTitles.value,
          fileId: uploadAiCubit.state.uploadAiImageState.data?.fileId ?? "",
          colors: cubit.segmentsColors.value,
        );
      },
      onTexturesSaved: () {
        // Texture saving is handled internally by the cubit
        // This callback is just for notification
      },
    );
  }

  void _onDownloadClicked(BuildContext context) async {
    if (isDownloading.value) return;
    try {
      isDownloading.value = true;
      final cubit = context.read<DesignSegmentsCubit>();
      final imageUrl = cubit.state.designSegmentsState.data?.originalImageUrl;
      if (imageUrl == null) return;
      final result = await ImageUtil.saveImageToGallery(imageUrl);
      if (result == null) {
        showSuccessToast('Image saved to gallery');
      } else {
        showErrorToast(result);
      }
    } finally {
      isDownloading.value = false;
    }
  }

  void _onShareClicked(BuildContext context) async {
    if (isSharing.value) return;
    try {
      isSharing.value = true;
      final cubit = context.read<DesignSegmentsCubit>();
      final imageUrl = cubit.state.designSegmentsState.data?.originalImageUrl;
      if (imageUrl == null) return;
      final imageBytes = await ImageUtil.downloadImage(imageUrl);
      if (imageBytes == null) {
        showErrorToast(LocaleKeys.error_error_happened.tr());
        return;
      }
      final File? screenShotFile =
          await ScreenShotHelper.writeUint8ListToTempFile(imageBytes);
      if (screenShotFile == null) {
        showErrorToast(LocaleKeys.error_error_happened.tr());
        return;
      }
      final files = [XFile(screenShotFile.path)];
      await Share.shareXFiles(
        files,
        text: tr(LocaleKeys.action_success),
      );
    } finally {
      isSharing.value = false;
    }
  }
}
