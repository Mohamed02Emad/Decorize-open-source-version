import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSegmentsTabButtons extends StatelessWidget {
  final ValueNotifier<int> currentPageIndex;
  final PageController pageController;

  const EditSegmentsTabButtons({
    super.key,
    required this.currentPageIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DesignSegmentsCubit>();
    return ValueListenableBuilder<int>(
      valueListenable: currentPageIndex,
      builder: (context, currentPage, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            12.gap,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  currentPageIndex.value = 0;
                  cubit.cancelTextureEditing();
                  pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: currentPage == 0
                        ? context.appColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: currentPage == 0
                          ? context.appColors.primary
                          : context.appColors.grey_2,
                    ),
                  ),
                  child: Text(
                    LocaleKeys.create_design_color.tr(),
                    style: TextStyles.semiBold14().copyWith(
                      color: currentPage == 0
                          ? Colors.white
                          : context.appColors.grey_2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  currentPageIndex.value = 1;
                  cubit.cancelTextureEditing();

                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: currentPage == 1
                        ? context.appColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: currentPage == 1
                          ? context.appColors.primary
                          : context.appColors.grey_2,
                    ),
                  ),
                  child: Text(
                    LocaleKeys.create_design_texture.tr(),
                    style: TextStyles.semiBold14().copyWith(
                      color: currentPage == 1
                          ? Colors.white
                          : context.appColors.grey_2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            12.gap,
          ],
        );
      },
    );
  }
}
