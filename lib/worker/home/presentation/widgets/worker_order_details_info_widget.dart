import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/datetime_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/worker/offers/domain/Enum/worker_offer_state.dart';
import 'package:decorizer/worker/offers/domain/Enum/worker_order_details_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/models/worker_order_details_model.dart';



class WorkerOrderDetailsInfoWidget extends StatelessWidget {
  final WorkerOrderDetailsModel orderDetails;

  const WorkerOrderDetailsInfoWidget({
    super.key,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              SvgPicture.asset(
                Assets.image.svg.info.path,
                width: 18.w,
                colorFilter: context.appColors.primary.colorFilter,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(LocaleKeys.order_details_order_info.tr(),
                    style: TextStyles.semiBold14(
                        color: context.appColors.primary)),
              ),
              Text(orderDetails.title, style: TextStyles.semiBold12()),
            ],
          ),
          Divider(height: 8.h).marginVertical(4),
          SizedBox(height: 8.h),
          _buildDetailRow(
            context: context,
            label: '${LocaleKeys.order_details_order_date.tr()} :',
            value: orderDetails.createdAt!.dateDdMmYyyy ?? '',
            valueColor: context.appColors.text,
          ),
          SizedBox(height: 8.h),
          _buildDetailRow(
            context: context,
            label: '${LocaleKeys.order_details_order_price.tr()} :',
            value: orderDetails.budget.toString().currency,
            valueColor: context.appColors.text,
          ),
          SizedBox(height: 8.h),
          _buildDetailRow(
            context: context,
            label: '${LocaleKeys.order_details_number_of_days.tr()} :',
            value: orderDetails.numberOfDays.toString() ,
            valueColor: context.appColors.text,
          ),
          if (orderDetails.myOfferStatus != null) ...[
            SizedBox(height: 8.h),
            _buildDetailRow(
              context: context,
              label: '${LocaleKeys.order_details_offers_offer_state.tr()} :',
              value: orderDetails.myOfferStatus!.displayName.tr(),
              valueColor: orderDetails.myOfferStatus!.color,
            ),
          ],
          SizedBox(height: 8.h),
          _buildDetailRow(
            context: context,
            label: '${LocaleKeys.order_details_order_state.tr()} :',
            value: orderDetails.status.displayName.tr(),
            valueColor: orderDetails.status.color,
          ),
          if (orderDetails.status == WorkerOrderDetailsStatus.cancelled) ...[
            SizedBox(height: 8.h),
            Text(
              LocaleKeys.order_details_cancelation_reason.tr(),
              style: TextStyles.regular14().copyWith(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                'عدم توفر الوقت الكافي لديه للتواصل مع النجار، حيث كان لديه التزامات شخصية أخرى تمنعه من متابعة الطلب.',
                style: TextStyles.regular13().copyWith(
                  color: Colors.red.shade700,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
          if (orderDetails.status == WorkerOrderDetailsStatus.inProgress && orderDetails.myOfferStatus == WorkerOfferState.approved) ...[
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: orderDetails.status.color.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                'قام العميل ببدء الطلب، يمكنك التوجه إلى الموقع في الموعد المتفق عليه بينكما للبدء في العمل.',
                style: TextStyles.regular13().copyWith(
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required BuildContext context,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.regular12().copyWith(
            color: context.appColors.grey_2,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyles.regular12().copyWith(
              color: valueColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
