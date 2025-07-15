import 'package:decorizer/common/app/app.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/theme/color/dark_app_colors.dart';
import 'package:decorizer/common/theme/color/light_app_colors.dart';
import 'package:decorizer/common/theme/shadows/dart_app_shadows.dart';
import 'package:decorizer/common/theme/shadows/light_app_shadows.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CustomTheme {
  dark(
    DarkAppColors(),
    DarkAppShadows(),
  ),
  light(
    LightAppColors(),
    LightAppShadows(),
  );

  const CustomTheme(this.appColors, this.appShadows);

  final AbstractThemeColors appColors;
  final AbsThemeShadows appShadows;

  ThemeData get themeData {
    switch (this) {
      case CustomTheme.dark:
        return darkTheme;
      case CustomTheme.light:
        return lightTheme;
    }
  }
}

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    scaffoldBackgroundColor: appContext!.appColors.background,
    appBarTheme: AppBarTheme(color: Colors.transparent),
    textTheme: _customTextTheme(Brightness.light),
    fontFamily: "IBM",
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appContext!.appColors.background,
    ),
    colorScheme:
        ColorScheme.fromSeed(seedColor: CustomTheme.light.appColors.seedColor));

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(color: Colors.transparent),
    scaffoldBackgroundColor: appContext!.appColors.background,
    fontFamily: "IBM",
    textTheme: _customTextTheme(Brightness.dark),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: appContext!.appColors.background),
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomTheme.dark.appColors.seedColor,
      brightness: Brightness.dark,
    ));

TextTheme _customTextTheme(
  Brightness brightness,
) {
  final textColor =
      brightness == Brightness.dark ? AppColors.white : AppColors.black;
  return GoogleFonts.anaheimTextTheme(
    ThemeData(brightness: brightness).textTheme.copyWith(
          titleLarge: TextStyles.bold16Weight700(color: textColor),
          titleMedium: TextStyles.bold14(color: textColor),
          titleSmall: TextStyles.bold12(color: textColor),
          bodyLarge: TextStyles.regular16(color: textColor),
          bodyMedium: TextStyles.regular14(color: textColor),
          bodySmall: TextStyles.regular12(color: textColor),
          labelLarge: TextStyles.semiBold16(color: textColor),
          labelMedium: TextStyles.semiBold14(color: textColor),
          labelSmall: TextStyles.semiBold12(color: textColor),
        ),
  );
}
