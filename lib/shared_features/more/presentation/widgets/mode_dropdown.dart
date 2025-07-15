import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../common/resources/gen/locale_keys.g.dart';

class ModeDropdownMenuItem extends StatelessWidget {
  final CustomTheme customTheme;

  const ModeDropdownMenuItem({
    super.key,
    required this.customTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _IconWidget(
            iconPath: customTheme.name == 'light' ? AppSvgs.sun : AppSvgs.moon),
        SizedBox(width: 12.w),
        Text(
          customTheme.name.capitalizeFirst == "Light"
              ? context.tr(LocaleKeys.common_light)
              : context.tr(LocaleKeys.common_dark),
          style: TextStyle(
            color: context.appColors.text,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}

class _IconWidget extends StatelessWidget {
  final String iconPath;

  const _IconWidget({
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.5,
      color: Colors.grey,
      offset: const Offset(2, 2),
      sigma: 2,
      child: SvgPicture.asset(
        iconPath,
        width: 20.w,
      ),
    );
  }
}
