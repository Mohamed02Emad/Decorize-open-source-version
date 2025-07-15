import 'package:decorizer/common/constant/app_constants.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double? height, fontSize;
  final bool isLoading, isWrapContent, isBordered, enabled;
  final Color? loadingColor,
      iconTint,
      textColor,
      rippleColor,
      backgroundColor,
      borderColor;
  final double? radius;
  final IconData? icon;
  final Widget? leading;
  final Function? onClick;
  final TextStyle? textStyle;
  final double? borderWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? innerPadding;

  AppButton({
    required this.text,
    this.borderColor,
    this.radius,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.isBordered = false,
    this.enabled = true,
    required this.onClick,
    this.rippleColor,
    this.icon,
    this.loadingColor,
    this.borderWidth,
    this.textColor,
    this.isWrapContent = false,
    this.leading,
    this.textStyle,
    this.isLoading = false,
    super.key,
    this.iconTint,
    this.height = 36,
    this.fontSize = 14,
  });

  AppButton.small({
    required this.text,
    this.borderColor,
    this.radius,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.isBordered = false,
    this.enabled = true,
    required this.onClick,
    this.rippleColor,
    this.loadingColor,
    this.icon,
    this.borderWidth,
    this.textColor,
    this.isWrapContent = false,
    this.leading,
    this.textStyle,
    this.isLoading = false,
    super.key,
    this.iconTint,
    this.height = 22,
    this.fontSize = 12,
  });

  AppButton.medium({
    required this.text,
    this.borderColor,
    this.radius,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.isBordered = false,
    this.enabled = true,
    required this.onClick,
    this.rippleColor,
    this.icon,
    this.loadingColor,
    this.borderWidth,
    this.textColor,
    this.isWrapContent = false,
    this.leading,
    this.textStyle,
    this.isLoading = false,
    super.key,
    this.iconTint,
    this.height = 30,
    this.fontSize = 14,
  });

  final marginHorizontal = EdgeInsets.symmetric(horizontal: 16.h);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: enabled.not(),
      child: Padding(
        padding: margin,
        child: Material(
          borderRadius:
              BorderRadius.circular(radius ?? AppConstants.mainCorner),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor:
                rippleColor ?? context.appColors.white.withOpacity(0.3),
            borderRadius:
                BorderRadius.circular(radius ?? AppConstants.mainCorner),
            onTap: () {
              if (isLoading.not()) onClick?.call();
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(radius ?? AppConstants.mainCorner),
                color: enabled
                    ? (backgroundColor ?? context.appColors.primary)
                    : (backgroundColor ?? context.appColors.primary)
                        .withOpacity(
                            (backgroundColor ?? context.appColors.primary)
                                    .opacity *
                                0.3),
                border: isBordered
                    ? Border.all(
                        width: borderWidth ?? 1.h,
                        color: borderColor ?? context.appColors.primary)
                    : null,
              ),
              child: Row(
                mainAxisSize:
                    isWrapContent.not() ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DynamicContainer(
                    padding: innerPadding ??
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                    child: SizedBox(
                      height: height ?? 40.h,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            isLoading
                                ? AppLoading(
                                    color:
                                        loadingColor ?? context.appColors.white,
                                    // isLottie: false,
                                    size: 25.w)
                                : Row(
                                    children: [
                                      if (leading != null) leading!,
                                      if (leading != null) SizedBox(width: 5.h),
                                      Text(
                                        text,
                                        style: textStyle ??
                                            TextStyle(
                                              color: textColor ??
                                                  (isBordered
                                                      ? borderColor
                                                      : context
                                                          .appColors.onPrimary),
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSize ?? 14.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
