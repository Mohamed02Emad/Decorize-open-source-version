import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelledMessageWidget extends StatelessWidget {
  const CancelledMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.cancel, color: Colors.red, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'تم إلغاء هذا الطلب من قبل العميل أو العامل',
              style: TextStyles.medium14().copyWith(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }
}
