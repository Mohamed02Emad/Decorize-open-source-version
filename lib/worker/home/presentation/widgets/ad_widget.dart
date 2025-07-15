import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AdWidget extends StatelessWidget {
  const AdWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 12.w , vertical: 10.h),
      padding: EdgeInsets.all(16),
      decoration:  BoxDecoration(
          shape: BoxShape.rectangle,
          color: context.appColors.primary,
          borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Right: Text and Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حقق طموحاتك، وابدأ رحلتك المهنية !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 8),
                Text(
                  '"انضم إلى مجتمعنا اليوم، وقدم طلبات الخدمات المتنوعة. '
                      'تواصل مباشرة مع العملاء وحقق النجاح الذي تستحقه!"',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.right,
                ),
                 AppButton.small(
                         text: 'ابدأ الان',
                         height: 20.h,
                         backgroundColor: Colors.white,
                         textColor: context.appColors.primary,
                         onClick: (){}
                     ).marginLeft(250.w).marginTop(20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
