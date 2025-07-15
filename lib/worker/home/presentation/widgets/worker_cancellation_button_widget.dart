import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/worker/offers/presentation/widgets/cancel_order_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerCancellationButtonWidget extends StatelessWidget {
  final int offerId ;
  final Function()? onRefresh;
  const WorkerCancellationButtonWidget({
    required this.offerId,
    this.onRefresh,
    super.key,});
  @override
  Widget build(BuildContext context) {
    return  FloatingCard(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child:  CancelButton(offerId: offerId, onRefresh: onRefresh,).marginBottom(8.h),
    );
  }
}
