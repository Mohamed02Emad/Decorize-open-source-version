import 'package:decorizer/common/data/preference/prefs.dart';
import 'package:decorizer/common/theme/custom_theme.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../common.dart';

class ThemeUtil {
  static Brightness get systemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static void changeTheme(BuildContext context, CustomTheme theme) {
    Prefs.appTheme.set(theme);
    context.changeTheme(theme);
  }

  static void changeThemeMode(BuildContext context, CustomTheme customTheme) {
    {
      switch (customTheme) {
        case CustomTheme.dark:
          SystemBarsUtil.changeStatusAndNavigationBars(isBlackIcons: false);
          changeTheme(context, CustomTheme.dark);
          break;
        case CustomTheme.light:
          SystemBarsUtil.changeStatusAndNavigationBars(isBlackIcons: true);
          changeTheme(context, CustomTheme.light);
          break;
      }
    }
  }

  static void toggleTheme(BuildContext context) {
    final theme = context.themeType;
    switch (theme) {
      case CustomTheme.dark:
        SystemBarsUtil.changeStatusAndNavigationBars(isBlackIcons: false);
        changeTheme(context, CustomTheme.light);
        break;
      case CustomTheme.light:
        SystemBarsUtil.changeStatusAndNavigationBars(isBlackIcons: true);
        changeTheme(context, CustomTheme.dark);
        break;
    }
  }
}
