import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconText extends StatelessWidget {
  final String icon, text;
  final Color? color;
  final double? iconSize, textSize;
  final bool isMaxSpaceBetween;
  final EdgeInsetsGeometry margin;

  const IconText(
      {super.key,
      required this.icon,
      required this.text,
      this.color,
      this.margin = EdgeInsets.zero,
      this.iconSize,
      this.isMaxSpaceBetween = false,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: iconSize ?? 12.w,
            color: color ?? context.appColors.text,
          ),
          isMaxSpaceBetween ? const Spacer() : Width(6.w),
          Text(
            text,
            style: TextStyles.regular13(
              color: color ?? context.appColors.text,
            ).copyWith(fontSize: textSize ?? 13.sp),
          )
        ],
      ),
    );
  }
}
