import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final Function()? onPressOverride;
  const AppBackButton({super.key, this.color, this.onPressOverride});

  @override
  Widget build(BuildContext context) {
    final backArrow = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;
    return Hero(
      tag: 'back_button',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.h),
        child: IconButton(
          icon: Icon(
            backArrow,
            size: 24.h,
            color: color ?? Colors.white,
          ),
          onPressed: onPressOverride ?? () => Nav.pop(context),
        ),
      ),
    );
  }
}
