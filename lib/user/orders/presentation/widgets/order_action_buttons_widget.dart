import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/app/app_button.dart';

class OrderActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const OrderActionButtonsWidget({
    super.key,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: AppButton(text: 'قبول', onClick: onAccept),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: AppButton(text: 'رفض', onClick: onAccept),
          ),
        ],
      ),
    );
  }
}
