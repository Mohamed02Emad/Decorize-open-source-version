import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dynamic_container.dart';

class PagingLoading extends StatelessWidget {
  final bool isPaging;
  final Widget child;

  const PagingLoading({super.key, required this.isPaging, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, bottom: 0, left: 0, right: 0, child: child),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: DynamicContainer(
            showChild: isPaging,
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.onBackground.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: AppLoading(
                size: 30.w,
              ).marginBottom(20.h).marginTop(8.h),
            ),
          ),
        ),
      ],
    );
  }
}
