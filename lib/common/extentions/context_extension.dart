import 'package:decorizer/common/theme/custom_theme.dart';
import 'package:decorizer/common/theme/custom_theme_holder.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common.dart';
import '../constant/app_constants.dart';

extension ContextExtension on BuildContext {
  void closeKeyboard() {
    FocusScope.of(this).unfocus();
  }

  bool get isArabic {
    return EasyLocalization.of(this)?.currentLocale?.languageCode == 'ar';
  }

  UserType? get currentUserType {
    try {
      return read<LoginInfoCubit>().user?.type;
    } catch (e) {
      mprint(e.toString());
      return null;
    }
  }

  bool get isDarkMode => themeType == CustomTheme.dark;

  List<BoxShadow> get boxShadow => [
        BoxShadow(
          color: appColors.shadowColor,
          blurRadius: AppConstants.shadowBlurRadius,
          spreadRadius: AppConstants.shadowSpreadRadius,
          offset: Offset(0, AppConstants.cardElevation),
        )
      ];

  double get deviceWidth {
    return MediaQuery.of(this).size.width;
  }

  double get deviceHeight {
    return MediaQuery.of(this).size.height;
  }

  Orientation get deviceOrientation {
    return MediaQuery.of(this).orientation;
  }

  double get statusBarHeight {
    return MediaQuery.of(this).padding.top;
  }

  double get viewPaddingBottom {
    return MediaQuery.of(this).padding.bottom;
  }

  double get viewPaddingTop {
    return MediaQuery.of(this).padding.top;
  }

  Brightness get platformBrightness {
    return MediaQuery.of(this).platformBrightness;
  }

  AbstractThemeColors get appColors => CustomThemeHolder.of(this).appColors;

  AbsThemeShadows get appShadows => CustomThemeHolder.of(this).appShadows;

  CustomTheme get themeType => CustomThemeHolder.of(this).theme;

  Function(CustomTheme) get changeTheme =>
      CustomThemeHolder.of(this).changeTheme;
}
