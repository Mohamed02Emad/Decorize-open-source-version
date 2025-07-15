import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/spaces.dart';

class MoreItem extends StatelessWidget {
  final String title, svgAsset;
  final Function() onClick;
  final bool isLoading;
  final double? iconSize;
  final Color? color;
  final Widget? trailingWidget;

  const MoreItem({
    super.key,
    required this.svgAsset,
    required this.onClick,
    required this.title,
    this.iconSize,
    this.color,
    this.isLoading = false,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            padding: 6.edgeInsetsAll,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.w),
              color: context.appColors.background,
              border: Border.all(color: Colors.black.withValues(alpha: 0.12)),
            ),
            child: Center(
              child: isLoading
                  ? AppLoading(
                      size: 22.h,
                      color: color,
                    )
                  : SvgPicture.asset(
                      svgAsset,
                      width: iconSize ?? 22.h,
                      height: iconSize ?? 22.h,
                      colorFilter:
                          (color ?? context.appColors.primary).colorFilter,
                    ),
            ),
          ),
          8.gap,
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.semiBold13(color : color),
          ),
          const Spacer(),
          if (trailingWidget != null) trailingWidget!,
          Width(12.w),
        ],
      ),
    ).clickable(
      onClick,
    );
  }
}
