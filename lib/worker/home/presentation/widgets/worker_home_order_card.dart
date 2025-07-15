import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/floating_card.dart';
import '../../../offers/domain/Enum/worker_offer_state.dart';
import '../../domain/models/worker_order_model.dart';
import '../pages/worker_order_details_screen.dart';
import 'bottom_sheets/application_buttom_sheet.dart';

class WorkerHomeOrderCard extends StatelessWidget {
  const WorkerHomeOrderCard({super.key, required this.order, this.onRefresh});
  final Function()? onRefresh;
  final WorkerOrderModel order;
  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      child: InkWell(
        onTap: _goToAdDetailsScreen,
        child: Ink(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppImage(
                path: order.files[0].url,
                radius: 4.r,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 160.h,
              ),
              4.gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.title,
                    style: TextStyles.semiBold14(),
                  ),
                  const Spacer(),
                  Text(
                    order.budget.currency,
                    style: TextStyles.semiBold14(
                      color: context.appColors.primary,
                    ),
                  ),
                ],
              ),
              ReadMoreText(
                order.content,
                trimMode: TrimMode.Line,
                trimLines: 2,
                trimCollapsedText: context.tr(LocaleKeys.OrderScreen_read_more),
                trimExpandedText: context.tr(LocaleKeys.OrderScreen_show_less),
                style: TextStyles.regular12(
                    context: context, color: context.appColors.hintText),
                colorClickableText: context.appColors.primary,
              ),
              SizedBox(height: 8.h),
              _buildActionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    switch (order.myOfferStatus) {
      case WorkerOfferState.pending:
      case WorkerOfferState.approved:
      case WorkerOfferState.rejected:
      case WorkerOfferState.cancelled:
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              context.tr(LocaleKeys.order_details_offers_offer_state) + ' : ',
              style: TextStyles.regular12(),
            ),
            Text(
              order.myOfferStatus?.displayName.tr() ?? '',
              style: TextStyles.semiBold12(
                  color:
                      order.myOfferStatus?.color ?? context.appColors.primary),
            ),
          ],
        );
      case null:
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppButton.medium(
                text: context.tr(LocaleKeys.home_apply_now),
                radius: 12.r,
                onClick: () => _openApplicationBottomSheet(context, onRefresh)),
          ],
        );
    }
  }

  void _goToAdDetailsScreen() {
    Nav.push(WorkerOrderDetailsScreen(orderId: order.id, offerState: order.myOfferStatus ));
  }

  void _openApplicationBottomSheet(
      BuildContext context, Function()? onRefresh) {
    ApplicationBottomSheet.show(
      context: context,
      postId: order.id,
      onRefresh: onRefresh,
    );
  }
}
