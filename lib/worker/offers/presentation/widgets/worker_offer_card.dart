import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/datetime_extension.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/common/widget/spaces.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentation/cubit/get_order_details/get_worker_order_details_cubit.dart';
import '../../../home/presentation/pages/worker_order_details_screen.dart';
import '../../domain/Enum/worker_offer_state.dart';
import '../../domain/models/worker_offer_model.dart';
import 'cancel_order_button.dart';

class WorkerOfferCard extends StatelessWidget {
  const WorkerOfferCard({
    super.key,
    required this.offer,
  });
 final WorkerOfferModel offer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToAdDetailsScreen,
      child: Ink(
        child: FloatingCard(
            padding: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsetsDirectional.only(
                  start: 12.w, end: 12.w, top: 8.h, bottom: 8.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        offer.post.id.toString(),
                        style: TextStyles.regular12Weight400(
                            color: context.appColors.grey, context: context),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(
                            height: 16.h,
                            width: 16.w,
                            AppSvgs.calendar,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            context.tr(offer.createdAt.dateDdMmYyyy),
                            style: TextStyles.regular12Weight400(
                                context: context,
                                color: context.appColors.hintText,
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Height(8.h),
                  Row(
                    children: [
                      if(offer.post.image != null)
                      Container(
                        height: 32.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4.r),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(offer.post.image!),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        offer.post.title,
                        style: TextStyles.semiBold14(
                          context: context,
                          //rgba(27, 29, 28, 1)
                          color: Color.fromARGB(255, 27, 29, 28),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 8.w, end: 8.w, top: 4.h, bottom: 4.h),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: offer.status.color.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Center(
                          child: Text(context.tr(offer.status.displayName),
                              style: TextStyles.semiBold12(
                                  color: offer.status.color, context: context)),
                        ),
                      )
                    ],
                  ),
                  Height(12.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppSvgs.dollarSquare,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        offer.budget.toString().currency,
                        style: TextStyles.semiBold12(
                            context: context, color: context.appColors.primary),
                      )
                    ],
                  ),
                  Height(16.h),
                   _showCardActionButton(context),
                ],
              ),
            )),
      ),
    );
  }

  Widget _showCardActionButton(BuildContext context) {
    switch (offer.status) {
      case WorkerOfferState.approved:
      case WorkerOfferState.rejected:
      case WorkerOfferState.cancelled:
        return const SizedBox.shrink();
      case WorkerOfferState.pending:
        return CancelButton(
          offerId: offer.id,
          onRefresh: () => _refresh(context),
        );
    }
  }
  void _refresh(BuildContext context)  {
    context.read<WorkerOrderDetailsCubit>().getWorkerOrderDetails(offer.post.id);
  }
  void _goToAdDetailsScreen() {
    Nav.push(WorkerOrderDetailsScreen(orderId: offer.post.id, offerState: offer.status,  cancelOfferId: offer.id,));
  }
}
