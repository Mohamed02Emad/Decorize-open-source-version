import 'package:decorizer/common/theme/color/abs_theme_colors.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class DarkAppColors extends AbstractThemeColors {
  const DarkAppColors();

  @override
  Color get seedColor => AppColors.primary;

  @override
  Color get primary => AppColors.primary;

  @override
  Color get activate => AppColors.primary;

  @override
  Color get onBackground => const Color(0xFF161618);

  @override
  Color get background => const Color(0xFF000000);

  @override
  Color get navigationBorder => const Color(0xFF161618);

  @override
  Color get badgeBg => AppColors.darkOrange;

  @override
  Color get divider => const Color.fromARGB(255, 93, 93, 93);

  @override
  Color get drawerBg => const Color.fromARGB(255, 42, 42, 42);

  @override
  Color get hintText => AppColors.grey;

  @override
  Color get iconButton => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get iconButtonInactivate => const Color.fromARGB(255, 131, 131, 131);

  @override
  Color get inActivate => const Color.fromARGB(255, 65, 68, 74);

  @override
  Color get text => Colors.white;

  @override
  Color get focusedBorder => AppColors.primary;

  @override
  Color get confirmText => AppColors.brightBlue;

  @override
  Color get blueButtonBackground => AppColors.blue;

  Color get veryBrightGrey => AppColors.grey;
}
