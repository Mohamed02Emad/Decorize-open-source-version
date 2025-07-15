import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/di/injection_container.dart';
import '../cubit/worker_navigation_cubit.dart';
import '../worker_nav_item.dart';

class WorkerNavNavigator extends StatelessWidget {
  final List<WorkerNavItem> items;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;
  final Color? titleColor;
  final Color? centerItemColor;
  final bool Function(int index)? onPageChanged;

  const WorkerNavNavigator({
    super.key,
    required this.items,
    this.selectedIconColor,
    this.unSelectedIconColor,
    this.titleColor,
    this.centerItemColor,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WorkerNavigationCubit>(),
      child: ValueListenableBuilder(
        valueListenable: sl<WorkerNavigationCubit>().currentIndexNotifier,
        builder: (context, currentIndex, child) => Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: items.map((e) => e.firstPage).toList(),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: context.appColors.onBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == currentIndex;
                final iconPath =
                isSelected ? item.activeIcon : item.inActiveIcon;
                final iconColor =
                isSelected ? selectedIconColor : unSelectedIconColor;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _changePage(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        bottom: isSelected ? 20.h : 22.h,
                        top: isSelected ? 14 : 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: isSelected ? 26.h : 20.h,
                            width: isSelected ? 26.h : 20.h,
                            child: SvgPicture.asset(
                              iconPath,
                              colorFilter: iconColor?.colorFilter,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr(item.tabName),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyles.semiBold12(
                                  color: isSelected
                                      ? selectedIconColor
                                      : unSelectedIconColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _changePage(int index) {
    if (onPageChanged?.call(index) ?? true) {
      sl<WorkerNavigationCubit>().setCurrentIndex(index);
    }
  }
}

class AnimatedCircleButton extends StatelessWidget {
  final bool isSelected;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback onTap;

  const AnimatedCircleButton({
    super.key,
    required this.isSelected,
    required this.iconPath,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final double innerSize = isSelected ? 56.w : 52.w;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border:
          Border.all(color: appColors.onPrimary, width: isSelected ? 6 : 6),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: appColors.white.withValues(alpha: 0.88),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(isSelected ? 6.h : 6.h),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: innerSize,
            width: innerSize,
            decoration: BoxDecoration(
              color: appColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                colorFilter: appColors.onPrimary.colorFilter,
                height: 28,
                width: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
