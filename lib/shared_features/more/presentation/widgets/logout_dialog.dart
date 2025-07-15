import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constant/textStyles.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';

class LogOutDialog extends StatelessWidget {
  final Function() onConfirmClicked;

  const LogOutDialog._({required this.onConfirmClicked});

  static void show(BuildContext context, Function() onConfirmClicked) {
    showDialog(
      context: context,
      builder: (context) => LogOutDialog._(
        onConfirmClicked: onConfirmClicked,
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
              SvgPicture.asset(
                AppSvgs.logOut,
                width: 90.w,
                colorFilter: context.appColors.primary.colorFilter,
              ).marginVertical(12.h).marginEnd(30.w),
              Text(
                context.tr(LocaleKeys.more_logoutMessage),
                textAlign: TextAlign.center,
                style: TextStyles.bold18(context: context),
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
                    child: AppButton(
                      text: tr(LocaleKeys.action_cancel),
                      // isWrapContent: true,
                      isBordered: true,
                      borderColor: context.appColors.primary,
                      backgroundColor: context.appColors.onBackground,
                      onClick: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                    child: AppButton(
                      rippleColor: context.appColors.red.withValues(alpha: 0.2),
                      text: tr(LocaleKeys.more_logout),
                      textColor: Colors.white,
                      onClick: () async {
                        Navigator.pop(context);
                        onConfirmClicked();
                      },
                      isWrapContent: true,
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
