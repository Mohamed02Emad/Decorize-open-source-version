import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../common/constant/app_svgs.dart';

class FilterSearchButton extends StatelessWidget {
  const FilterSearchButton(
      {super.key, required this.onTap, this.hasFilter = false});
  final Function() onTap;
  final bool hasFilter;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: context.appColors.primary, width: 1.w),
        borderRadius: BorderRadius.circular(8),
        color: hasFilter ? context.appColors.primary : context.appColors.onBackground,
      ),
      height: 40.h,
      width: 40.w,
      child: SvgPicture.asset(
        AppSvgs.filterSearch,
        width: 20.w,
        height: 20.h,
        colorFilter: hasFilter
            ? context.appColors.white.colorFilter
            : context.appColors.primary.colorFilter,
        fit: BoxFit.scaleDown,
      ),
    ).clickable(() {
      onTap();
    }, radius: 8);
  }
}
