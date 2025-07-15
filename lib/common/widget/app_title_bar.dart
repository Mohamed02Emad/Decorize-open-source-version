import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/textStyles.dart';
import 'back_button.dart';

class AppTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool hasBackButton;
  final bool centerTitle;

  final double? height;
  final Function()? onBackPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool addSafeAreaSpace;
  final double? radius;
  final bool isElevated;
  final Widget? actions;

  const AppTitleBar({
    super.key,
    required this.title,
    this.hasBackButton = false,
    this.addSafeAreaSpace = true,
    this.textColor,
    this.height,
    this.radius,
    this.isElevated = true,
    this.backgroundColor,
    this.centerTitle = true,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: (height ?? 60.h) +
              (addSafeAreaSpace ? MediaQuery.of(context).padding.top : 0),
          decoration: BoxDecoration(
            color: backgroundColor ?? context.appColors.onBackground,
            borderRadius: BorderRadius.only(
                bottomLeft: (radius ?? 14).radius,
                bottomRight: (radius ?? 14).radius),
            boxShadow: isElevated ? context.boxShadow : null,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: hasBackButton ? 4.w : 16.w,
          ).copyWith(
              top: addSafeAreaSpace ? MediaQuery.of(context).padding.top : 0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (hasBackButton)
                  SizedBox(
                    height: 40.w,
                    width: 40.w,
                    child: FittedBox(
                      child: AppBackButton(
                        color: textColor ?? context.appColors.text,
                        onPressOverride: onBackPressed,
                      ),
                    ),
                  ),
                if (centerTitle && hasBackButton.not())
                  Container(
                    width: 40.w,
                  ),
                if (centerTitle) const Spacer(),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.semiBold14(
                      color: textColor ?? context.appColors.text),
                ),
                const Spacer(),
                if (centerTitle)
                  Container(
                    width: 40.w,
                  ),
              ],
            ),
          ),
        ),
        if (actions != null)
          PositionedDirectional(
            end: 0,
            top: addSafeAreaSpace
                ? MediaQuery.of(Nav.globalContext).padding.top
                : 0,
            bottom: 0,
            child: actions!,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((height ?? 60.h) +
      (addSafeAreaSpace ? MediaQuery.of(Nav.globalContext).padding.top : 0));
}
