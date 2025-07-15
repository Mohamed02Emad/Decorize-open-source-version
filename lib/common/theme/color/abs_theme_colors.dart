import 'package:flutter/material.dart';

import 'app_colors.dart';


typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get primary => AppColors.primary;
  Color get primaryLight => AppColors.primaryLight;
  Color get grey => AppColors.grey;
  Color get grey_2 => AppColors.grey_2;
  Color get grey_3 => AppColors.grey_3;
  Color get red => const Color(0xBFE80606);
  Color get green => const Color(0xBF6AD902);
  Color get shadowColor => grey.withOpacity(0.2);

  Color get splashColor => const Color(0xBF525252);
  Color get background => const Color(0xFFF5F5F5);
  Color get transparent => Colors.transparent;

  Color get white => const Color(0xFFF7FCF7);

  Color get onPrimary => const Color.fromARGB(255, 255, 251, 251);
  Color get onBackground => const Color.fromARGB(255, 255, 255, 255);
  Color get navigationBorder => const Color.fromARGB(0, 255, 255, 255);

  Color get seedColor => const Color(0xc5137);

  Color get veryBrightGrey => AppColors.brightGrey;

  Color get drawerBg => const Color.fromARGB(255, 255, 255, 255);

  Color get scrollableItem => const Color.fromARGB(255, 57, 57, 57);

  Color get iconButton => const Color.fromARGB(255, 0, 0, 0);

  Color get iconButtonInactivate => const Color.fromARGB(255, 162, 162, 162);

  Color get inActivate => const Color.fromARGB(255, 200, 207, 220);

  Color get activate => const Color.fromARGB(255, 63, 72, 95);

  Color get badgeBg => AppColors.blueGreen;

  Color get textBadgeText => Colors.white;

  Color get badgeBorder => Colors.transparent;

  Color get divider => const Color.fromARGB(255, 228, 228, 228);

  Color get text => AppColors.darkGrey;

  Color get hintText => AppColors.middleGrey;

  Color get focusedBorder => AppColors.primary;

  Color get confirmText => AppColors.blue;

  Color get drawerText => text;

  Color get snackbarBgColor => AppColors.mediumBlue;

  Color get blueButtonBackground => AppColors.darkBlue;
}
