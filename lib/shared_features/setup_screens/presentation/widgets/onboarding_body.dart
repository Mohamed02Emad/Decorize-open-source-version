import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/spaces.dart';

class OnBoardingBody extends StatelessWidget {
  final String svgAsset, text, subTitle;

  const OnBoardingBody(
      {super.key,
      required this.svgAsset,
      required this.text,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 1,
        ),
        SvgPicture.asset(
          svgAsset,
          width: 260.h,
          height: 260.h,
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: context.appColors.primary),
        ).marginHorizontal(16.w),
        Height(40.h),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ).marginHorizontal(16.w),
        Height(80.h),
      ],
    );
  }
}
