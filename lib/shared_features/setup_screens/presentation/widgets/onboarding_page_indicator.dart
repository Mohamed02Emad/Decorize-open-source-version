import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/theme/color/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  const OnboardingPageIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin:
                EdgeInsets.symmetric(horizontal: currentPage == 0 ? 3.h : 4.w),
            height: currentPage == 0 ? 9.h : 6.h,
            width: currentPage == 0 ? 24.w : 12.w,
            decoration: BoxDecoration(
              color: currentPage == 0 ? AppColors.primary : AppColors.grey_2,
              borderRadius: BorderRadius.circular(currentPage == 0 ? 4.h : 8.r),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin:
                EdgeInsets.symmetric(horizontal: currentPage == 1 ? 3.h : 4.w),
            height: currentPage == 1 ? 9.h : 6.h,
            width: currentPage == 1 ? 24.w : 12.w,
            decoration: BoxDecoration(
              color: currentPage == 1 ? AppColors.primary : AppColors.grey_2,
              borderRadius: BorderRadius.circular(currentPage == 1 ? 4.h : 8.r),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin:
                EdgeInsets.symmetric(horizontal: currentPage == 2 ? 3.h : 4.w),
            height: currentPage == 2 ? 9.h : 6.h,
            width: currentPage == 2 ? 24.w : 12.w,
            decoration: BoxDecoration(
              color: currentPage == 2 ? AppColors.primary : AppColors.grey_2,
              borderRadius: BorderRadius.circular(currentPage == 2 ? 4.h : 8.r),
            ),
          ),
        ],
      ),
    );
  }
}
