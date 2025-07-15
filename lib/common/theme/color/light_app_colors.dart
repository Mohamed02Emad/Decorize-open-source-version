import 'package:decorizer/common/theme/color/abs_theme_colors.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class LightAppColors extends AbstractThemeColors {
  const LightAppColors();

  @override
  Color get seedColor => AppColors.primary;

  @override
  Color get activate => AppColors.primary;

  @override
  Color get focusedBorder => AppColors.primary;
}
