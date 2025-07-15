import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:decorizer/user/bottom_navigation/user_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/di/injection_container.dart';
import '../cubits/user_navigation_cubit.dart';

class UserCustomBottomNav extends StatelessWidget {
  final List<UserNavItem> items;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;
  final Color? titleColor;
  final Color? centerItemColor;
  final bool Function(int index)? onPageChanged;

  const UserCustomBottomNav({
    super.key,
    required this.items,
    this.selectedIconColor,
    this.unSelectedIconColor,
    this.titleColor,
    this.centerItemColor,
    this.onPageChanged,
  }) : assert((items.length % 2 == 1) && items.length >= 3,
            'Must be odd and >= 3');

  @override
  Widget build(BuildContext context) {
    final centerIndex = items.length ~/ 2;
    return BlocProvider(
      create: (context) => sl<UserNavigationCubit>(),
      child: ValueListenableBuilder(
        valueListenable: sl<UserNavigationCubit>().currentIndexNotifier,
        builder: (context, currentIndex, child) => Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: items.map((e) => e.screen).toList(),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? context.appColors.onBackground
                  : context.appColors.onPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final UserNavItem item = items[index];
                final isSelected = index == currentIndex;
                final iconPath =
                    isSelected ? item.selectedSvgPath : item.unSelectedSvgPath;
                final iconColor =
                    isSelected ? selectedIconColor : unSelectedIconColor;
                final isChat =
                    item.title == LocaleKeys.bottomNavigation_messages;

                if (index == centerIndex) {
                  return Transform.translate(
                    offset: Offset(0, -24.h),
                    child: AnimatedCircleButton(
                      isSelected: isSelected,
                      iconPath: iconPath,
                      backgroundColor: centerItemColor ??
                          (context.isDarkMode
                              ? context.appColors.text
                              : context.appColors.primary),
                      onTap: () => _changePage(index),
                    ),
                  );
                }
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _changePage(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      color: context.isDarkMode
                          ? context.appColors.onBackground
                          : Colors.transparent,
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
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    iconPath,
                                    colorFilter: iconColor?.colorFilter,
                                  ),
                                ),
                                if (isChat)
                                  BlocBuilder<UnreadMessageCountCubit,
                                      UnreadMessageCountState>(
                                    builder: (context, state) =>
                                        (state.unreadCountState.data ?? 0) == 0
                                            ? const SizedBox.shrink()
                                            : Positioned(
                                                top: -6,
                                                right: -6,
                                                child: Container(
                                                  width: 14.w,
                                                  height: 14.w,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      state
                                                          .unreadCountState.data
                                                          .toString(),
                                                      style:
                                                          TextStyles.regular10(
                                                        color: context
                                                            .appColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr(item.title),
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
      sl<UserNavigationCubit>().setCurrentIndex(index);
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
          color: context.isDarkMode ? appColors.onBackground : backgroundColor,
          shape: BoxShape.circle,
          border:
              Border.all(color: context.isDarkMode ? appColors.onBackground : appColors.onPrimary, width: isSelected ? 6 : 6),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: context.isDarkMode ? appColors.primary.withValues(alpha: 0.4) : appColors.white.withValues(alpha: 0.88),
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
