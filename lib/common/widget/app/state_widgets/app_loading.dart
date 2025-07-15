import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  final double? size;
  const AppLoading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 50.h,
        height: size ?? 50.h,
        child: Lottie.asset(
          Assets.animations.loading.path,
          width: size ?? 50.h,
          height: size ?? 50.h,
        ),
      ),
    );
}
}
