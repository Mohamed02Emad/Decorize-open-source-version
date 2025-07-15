import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDescriptionWidget extends StatelessWidget {
  final String serviceDescription;

  const OrderDescriptionWidget({
    super.key,
    required this.serviceDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'وصف الخدمة',
            style: TextStyles.semiBold16(),
          ),
          SizedBox(height: 8.h),
          Text(
            serviceDescription,
            style: TextStyles.regular14().copyWith(color: Colors.grey[700]),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
