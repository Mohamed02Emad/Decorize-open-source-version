import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSegmentsPageIndicator extends StatelessWidget {
  final ValueNotifier<int> currentPageIndex;

  const EditSegmentsPageIndicator({
    super.key,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageIndex,
      builder: (context, currentIndex, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.create_design_color.tr(),
              style: TextStyles.semiBold14(),
            ),
            Text(
              LocaleKeys.create_design_texture.tr(),
              style: TextStyles.semiBold14(),
            ),
          ].asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: currentIndex == entry.key ? 18.w : 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.8),
                  width: 1,
                ),
                color: currentIndex == entry.key
                    ? context.appColors.primary
                    : const Color.fromARGB(255, 214, 214, 214)
                        .withValues(alpha: 0.4),
              ),
            );
          }).toList(),
        ).marginBottom(32);
      },
    );
  }
}
