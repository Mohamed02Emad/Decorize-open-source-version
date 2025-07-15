import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_animations.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppNoDataAnim extends StatelessWidget {
  final String? message;
  final Function()? onRefresh;
  const AppNoDataAnim({super.key, this.message, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AppAnimations.noDataAnimation),
          if (message != null)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message!,
                  style: TextStyle(
                      color: context.appColors.text,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp),
                )
              ],
            ),
          if (onRefresh != null)
            AppButton(
              text: context.tr('refresh'),
              onClick: onRefresh!,
              isBordered: true,
              backgroundColor: Colors.transparent,
              isWrapContent: true,
            ),
        ],
      ),
    );
  }
}
