import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool) onClick;
  final bool showBorders;
  final double size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppCheckBox({
    required this.isChecked,
    required this.onClick,
    this.showBorders = true,
    this.size = 21.0,
    this.padding,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: SizedBox(
        width: size.h,
        height: size.h,
        child: Checkbox(
          side: showBorders
              ? null
              : BorderSide(
                  color: context.appColors.primary,
                  width: 1.w,
                ),
          value: isChecked,
          checkColor: context.appColors.primary,
          activeColor: Colors.transparent,
          shape: showBorders
              ? null
              : RoundedRectangleBorder(
                  side:
                      BorderSide(width: 1.w, color: context.appColors.primary),
                ),
          onChanged: (bool? value) {
            if (value != null) {
              onClick(value);
            }
          },
        ),
      ),
    );
  }
}
