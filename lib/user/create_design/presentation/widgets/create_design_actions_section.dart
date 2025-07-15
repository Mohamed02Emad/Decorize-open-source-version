import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/user/create_design/presentation/cubits/suggest_design_cubit/suggest_design_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateDesignActionsSection extends StatelessWidget {
  final File image;
  final String projectId;
  final String? description , fileId;
  const CreateDesignActionsSection(
      {super.key,
      required this.image,
      required this.projectId,
      this.description,
      this.fileId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.appColors.onBackground),
      padding:
          EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h, bottom: 16.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.12),
              borderRadius: 8.r.borderRadius,
            ),
            child: Center(
              child: SvgPicture.asset(Assets.image.svg.shareDesign.path),
            ),
          ).clickable(
            _onShareClicked,
            color: context.appColors.primary,
          ),
          Expanded(
            child: AppButton(
              text: context.tr(LocaleKeys.create_design_change),
              leading: SvgPicture.asset(Assets.image.svg.change.path),
              margin: 24.edgeInsetsHorizontal,
              onClick: () => _changeClicked(context),
            ),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.appColors.primary.withValues(alpha: 0.12),
              borderRadius: 8.r.borderRadius,
            ),
            padding: 6.edgeInsetsAll,
            child: Center(
              child: SvgPicture.asset(Assets.image.svg.download.path),
            ),
          ).clickable(
            _onDownloadClicked,
            color: context.appColors.primary,
          ),
        ],
      ),
    );
  }

  void _onShareClicked() {}

  void _onDownloadClicked() {}

  void _changeClicked(BuildContext context) async {
    final cubit = context.read<SuggestDesignCubit>();
    cubit.suggestDesign(
        image: image,
        projectId: projectId,
        promptArabic: description ?? '',
        fileId: fileId,
        isRecreate: true);
  }
}
