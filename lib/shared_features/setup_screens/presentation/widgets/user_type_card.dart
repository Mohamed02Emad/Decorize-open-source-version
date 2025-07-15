import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_constants.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/widget/spaces.dart';
import '../../../auth/domain/enums/user_type.dart';

class UserTypeCard extends StatelessWidget {
  final UserType value;
  final UserType selectedUserType;
  final Function(UserType) onClick;

  const UserTypeCard(
      {super.key,
      required this.value,
      required this.selectedUserType,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == selectedUserType;
    final animationDuration = const Duration(milliseconds: 250);
    return AnimatedContainer(
      duration: animationDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        border: isSelected
            ? Border.all(color: context.appColors.primary, width: 1.0.w)
            : null,
        boxShadow: isSelected ? [
          BoxShadow(
            color: context.appColors.text.withValues(alpha: 0.4),
            blurRadius: AppConstants.shadowBlurRadius ,
            spreadRadius: AppConstants.shadowSpreadRadius ,
            offset: Offset(0, AppConstants.cardElevation),
          )
        ] : null,
      ),
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              margin: EdgeInsetsDirectional.only(
                  top: 15.5.h, start: 15.w, end: 15.w),
              height: 16.h,
              width: 16.w,
              child: Radio(
                  toggleable: false,
                  value: value,
                  groupValue: selectedUserType,
                  onChanged: (UserType? value) {}),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: AnimatedContainer(
              duration: animationDuration,
              margin: (isSelected ? 0.h : 18.h).edgeInsetsBottom,
              height: isSelected ? 80.h : 60.h,
              width: isSelected ? 80.w : 60.w,
              child: Image.asset(
                value.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Height(16.h),
          AnimatedDefaultTextStyle(
            duration: animationDuration,
            style: TextStyles.regular18(context: context)
                .copyWith(fontSize: isSelected ? 18.sp : 14.sp),
            child: Text(
              context.tr(value.displayName),
            ),
          ),
          Height(12.h),
        ],
      ).clickable(() {
        onClick(value);
      }),
    );
  }
}
