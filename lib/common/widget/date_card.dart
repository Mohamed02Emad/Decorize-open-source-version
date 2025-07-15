import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/dateUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/textStyles.dart';

class DateCard extends StatelessWidget {
  final DateTime? date;
  final String title;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final double? borderWidth, titleSize, radius;
  final Function(DateTime?) onDateChanged;

  const DateCard(
      {super.key,
      this.date,
      this.margin,
      this.radius,
      required this.onDateChanged,
      required this.title,
      this.backgroundColor,
      this.padding,
      this.borderWidth,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.regular13().copyWith(fontSize: titleSize),
        ).marginBottom(6.h),
        Container(
          margin: margin ?? EdgeInsetsDirectional.only(end: 10.w, top: 4.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? context.appColors.transparent,
            borderRadius: BorderRadius.circular(
              radius ?? 6.r,
            ),
            border: Border.all(
                color: context.appColors.grey, width: borderWidth ?? 0.4.w),
          ),
          child: Padding(
            padding: padding ??
                EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Row(
              children: [
                Text(
                  date == null
                      ? 'select'.tr()
                      : DateUtil.formatTimestampToString(date!),
                  style: TextStyles.regular12(),
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppSvgs.calendar,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(
                    context.appColors.text,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ).clickable(() => _selectDateTime(context)),
        )
      ],
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().copyWith(year: DateTime.now().year - 10),
      lastDate: DateTime.now().copyWith(year: DateTime.now().year + 100),
    );
    if (picked != null) {
      onDateChanged(picked);
      // dateController.text = DateUtil.formatTimestampToString(picked);
    }
  }
}
