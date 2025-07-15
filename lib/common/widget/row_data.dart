import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowData extends StatelessWidget {
  final String title, value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final Color? titleColor, valueColor, lineColor;
  final bool showBottomLine;
  final EdgeInsetsGeometry margin;

  const RowData({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
    this.margin = EdgeInsets.zero,
    this.titleColor,
    this.lineColor,
    this.showBottomLine = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle ??
                    TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: titleColor ?? context.appColors.text),
              ),
              Width(6.w),
              Flexible(
                child: Text(
                  value,
                  style: valueStyle ??
                      TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: valueColor ?? context.appColors.text),
                ),
              ),
            ],
          ),
          Container(
            color: lineColor ?? context.appColors.text,
            height: 1.h,
            width: double.infinity,
            margin: EdgeInsets.only(top: 12.h),
          )
        ],
      ),
    );
  }
}
