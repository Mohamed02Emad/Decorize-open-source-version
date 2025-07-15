import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/theme/custom_theme.dart';
import 'package:decorizer/common/theme/theme_util.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'mode_dropdown.dart';

class ChangeModeWidget extends StatelessWidget {
  const ChangeModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ValueNotifier<CustomTheme>(context.themeType);

    return ValueListenableBuilder<CustomTheme>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        final otherTheme = CustomTheme.values.firstWhere(
          (theme) => theme != currentTheme,
        );

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 6.w).copyWith(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            border: Border.all(color: context.appColors.veryBrightGrey),
            borderRadius: BorderRadius.circular(12.r),
            color: context.appColors.transparent,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentTheme.name.capitalizeFirst,
              elevation: 1,
              borderRadius: BorderRadius.circular(12.r),
              items: [currentTheme, otherTheme].map((theme) {
                return DropdownMenuItem<String>(
                  value: theme.name.capitalizeFirst,
                  child: ModeDropdownMenuItem(customTheme: theme),
                );
              }).toList(),
              onChanged: (String? selectedValue) {
                if (selectedValue == null) return;

                final selectedTheme = CustomTheme.values.firstWhere(
                  (theme) => theme.name == selectedValue.toLowerCase(),
                );

                if (selectedTheme != currentTheme) {
                  SystemBarsUtil.changeStatusAndNavigationBars(
                    statusBarColor: context.appColors.transparent,
                    navBarColor: context.appColors.onBackground,
                    isBlackIcons:
                        ContextExtension(context).isDarkMode ? false : true,
                  );
                  themeNotifier.value = selectedTheme;
                  ThemeUtil.changeThemeMode(context, selectedTheme);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
