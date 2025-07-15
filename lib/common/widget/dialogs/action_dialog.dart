import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';
import '../app/app_button.dart';

class ActionDialog extends StatelessWidget {
  final Function() onPositiveClicked;
  final Function()? onNegativeClicked;
  final String title;
  final String? message, positiveText, negativeText, svgPath;
  final Color? titleColor,
      positiveTextColor,
      negativeTextColor,
      messageColor,
      positiveButtonColor,
      negativeButtonColor,
      iconColor;
  final double? iconSize;

  const ActionDialog._({
    required this.onPositiveClicked,
    required this.title,
    this.onNegativeClicked,
    this.message,
    this.positiveText,
    this.negativeText,
    this.svgPath,
    this.titleColor,
    this.positiveTextColor,
    this.negativeTextColor,
    this.messageColor,
    this.positiveButtonColor,
    this.negativeButtonColor,
    this.iconColor,
    this.iconSize,
  });

  static void showDeleteDialog(
    BuildContext context, {
    required Function() onPositiveClicked,
    Function()? onNegativeClicked,
    String? title,
    String? message,
    String? positiveText,
    String? negativeText,
    String? svgPath,
    Color? titleColor,
    Color? positiveTextColor,
    Color? negativeTextColor,
    Color? messageColor,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
    Color? iconColor,
    double? iconSize,
  }) {
    show(context,
        onPositiveClicked: onPositiveClicked,
        onNegativeClicked: onNegativeClicked,
        title: title ?? LocaleKeys.common_delete.tr(),
        message: message ?? LocaleKeys.common_messages_delete_order.tr(),
        positiveText: positiveText ?? LocaleKeys.action_delete.tr(),
        negativeText: negativeText ?? LocaleKeys.action_cancel.tr(),
        svgPath: svgPath,
        titleColor: titleColor,
        positiveTextColor: positiveTextColor ?? Colors.white,
        negativeTextColor: negativeTextColor,
        messageColor: messageColor,
        positiveButtonColor: positiveButtonColor ?? context.appColors.red,
        negativeButtonColor: negativeButtonColor ?? context.appColors.onBackground,
        iconColor: iconColor,
        iconSize: iconSize);
  }

  static void show(
    BuildContext context, {
    required Function() onPositiveClicked,
    Function()? onNegativeClicked,
    required String title,
    String? message,
    String? positiveText,
    String? negativeText,
    String? svgPath,
    Color? titleColor,
    Color? positiveTextColor,
    Color? negativeTextColor,
    Color? messageColor,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
    Color? iconColor,
    double? iconSize,
  }) {
    showDialog(
      context: context,
      builder: (context) => ActionDialog._(
        onPositiveClicked: onPositiveClicked,
        onNegativeClicked: onNegativeClicked,
        title: title,
        message: message,
        positiveText: positiveText,
        negativeText: negativeText,
        svgPath: svgPath,
        titleColor: titleColor,
        positiveTextColor: positiveTextColor,
        negativeTextColor: negativeTextColor,
        messageColor: messageColor,
        positiveButtonColor: positiveButtonColor,
        negativeButtonColor: negativeButtonColor,
        iconColor: iconColor,
        iconSize: iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scaledRadius = 12.h;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaledRadius),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      elevation: 0,
      backgroundColor: context.appColors.onBackground,
      child: Material(
        borderRadius: BorderRadius.circular(scaledRadius),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: context.appColors.onBackground,
            borderRadius: BorderRadius.circular(scaledRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              12.h.gap,
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath ?? '',
                  width: iconSize ?? 60.w,
                  height: iconSize,
                  colorFilter: iconColor?.colorFilter ??
                      context.appColors.primary.colorFilter,
                ).marginBottom(12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.bold18(context: context, color: titleColor),
              ),
              SizedBox(
                height: 12.h,
              ),
              if (message != null)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        message ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyles.semiBold14(
                            context: context,
                            color: messageColor ?? context.appColors.hintText),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                    child: AppButton.small(
                      text: negativeText ?? tr(LocaleKeys.action_cancel),
                      // isWrapContent: true,
                      isBordered: true,
                      borderColor: context.appColors.text,
                      textColor: negativeTextColor,
                      height: 40.h,
                      backgroundColor:
                          negativeButtonColor ?? context.appColors.onBackground,
                      onClick: () {
                        Navigator.pop(context);
                        onNegativeClicked?.call();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                    child: AppButton.small(
                      rippleColor: context.appColors.red.withValues(alpha: 0.2),
                      text: positiveText ?? LocaleKeys.action_ok.tr(),
                      textColor: positiveTextColor ?? Colors.white,
                      height: 40.h,
                      onClick: () async {
                        Navigator.pop(context);
                        onPositiveClicked();
                      },
                      isWrapContent: true,
                      backgroundColor: positiveButtonColor,
                      borderColor: context.appColors.onBackground,
                    ),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
