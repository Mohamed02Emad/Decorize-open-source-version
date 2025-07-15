import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../constant/app_animations.dart';
import '../../spaces.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Function()? onRefresh;

  const AppErrorWidget({super.key, required this.errorMessage, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppAnimations.error, width: 150.w, height: 150.h).fadeScaleAppear(),
          Text(errorMessage , textAlign: TextAlign.center,).fadeAppear(),

          if (onRefresh != null) ...{
            Height(20.h),
            AppButton(text: 'refresh', onClick: onRefresh!).fadeScaleAppear(),
          },
        ],
      ),
    );
  }
}
