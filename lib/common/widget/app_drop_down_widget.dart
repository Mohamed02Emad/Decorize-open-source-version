import 'package:decorizer/common/constant/app_constants.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDown<T> extends StatelessWidget {
  final String? title, hint;
  final TextStyle? titleStyle;
  final Widget? icon;
  final dynamic value, onChange;
  final List<DropdownMenuItem<T>> items;
  final double? linePadding, titlePadding;
  final Color? backgroundColor;
  final bool fullBorder, isEnabled;
  final EdgeInsetsGeometry margin;

  const AppDropDown({
    Key? key,
    this.icon,
    this.isEnabled = true,
    this.margin = EdgeInsets.zero,
    this.title,
    this.linePadding = 0,
    this.titlePadding,
    required this.hint,
    this.value,
    this.fullBorder = true,
    required this.onChange,
    required this.items,
    this.titleStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: EdgeInsets.only(
                  left: titlePadding ?? 0,
                  right: titlePadding ?? 0,
                  top: 4.h,
                  bottom: 6.h),
              child: Text(
                title!,
                style: titleStyle ??
                    TextStyle(
                        color: context.appColors.text,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp),
              ),
            ),
          DropdownButtonFormField<T>(
            padding: EdgeInsets.zero,
            isExpanded: true,
            items: items,
            hint: hint != null
                ? Text(
                    hint!,
                    style:
                        TextStyles.regular13(color: context.appColors.hintText),
                  )
                : null,
            value: value,
            onChanged: isEnabled ? onChange : null,
            style: TextStyle(color: context.appColors.text, fontSize: 16.sp),
            iconDisabledColor:
                isEnabled ? context.appColors.text : context.appColors.grey,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              border: fullBorder
                  ? OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.mainCorner),
                    )
                  : const UnderlineInputBorder(),
              filled: true,
              fillColor: backgroundColor ?? context.appColors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
