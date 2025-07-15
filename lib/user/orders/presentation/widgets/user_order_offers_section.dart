import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit.dart';
import 'package:decorizer/user/orders/presentation/cubits/user_order_details/user_order_details_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/bottom_sheets/show_all_offers_bottom_sheet.dart';
import 'package:decorizer/user/orders/presentation/widgets/applied_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrderOffersSection extends StatelessWidget {
  final OrderDetailsModel orderDetails;

  const UserOrderOffersSection({
    super.key,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.image.svg.profile2.path,
                width: 18.w,
                colorFilter: context.appColors.primary.colorFilter,
              ),
              SizedBox(width: 8.w),
              Text(
                  orderDetails.status.isPending
                      ? LocaleKeys.order_details_applied.tr()
                      : LocaleKeys.order_details_workers.tr(),
                  style:
                  TextStyles.semiBold14(color: context.appColors.primary)),
              const Spacer(),
              BlocBuilder<GetOrderOffersCubit, GetOrderOffersState>(
                builder: (context, state) => DynamicContainer(
                  showChild:
                  state.getOrderOffersState.data?.isNotEmpty ?? false,
                  child: Text(LocaleKeys.common_see_all.tr(),
                      style: TextStyles.semiBold12(
                          color: context.appColors.primary))
                      .marginVertical(4.h)
                      .clickable(() {
                    _showAllOffers(context);
                  }, radius: 6.r),
                ),
              ),
            ],
          ).marginHorizontal(8.w).marginTop(12.h),
          Divider(height: 2.h).marginTop(8).marginHorizontal(8.w),
          DynamicContainer(
            showChild: true,
            child: BlocBuilder<GetOrderOffersCubit, GetOrderOffersState>(
              builder: (context, state) => state.getOrderOffersState.build(
                loadingWidget: Skeleton(
                  width: double.infinity,
                  height: 100.h,
                ),
                successBuilder: (List<OfferModel> data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        LocaleKeys.order_details_offers_no_offers.tr(),
                        style: TextStyles.semiBold13(
                            color: context.appColors.primary),
                      ).marginVertical(16.h),
                    );
                  }
                  return ListView.builder(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppliedOfferCard(
                            orderStatus: orderDetails.status,
                            offer: data[index],
                            onOfferUpdated: (offer) {
                              _onOfferUpdated(context, offer);
                            },
                          ).marginHorizontal(4.w),
                          if (index < (data.length > 4 ? 4 : data.length) - 1)
                            Divider(
                              height: 6,
                            ).marginVertical(8),
                        ],
                      );
                    },
                    itemCount: data.length > 4 ? 4 : data.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ).fadeScaleAppear();
  }

  void _showAllOffers(BuildContext context) {
    ShowAllOffersBottomSheet.show(context,
        orderStatus: orderDetails.status);
  }

  void _onOfferUpdated(BuildContext context, OfferModel offer) {
    context.read<GetOrderOffersCubit>().updateOffer(offer);
    final numberOfApprovedOffers =
        context.read<GetOrderOffersCubit>().numberOfApprovedOffers;
    context.read<UserOrderDetailsCubit>().updateNumberOfApprovedOffers(numberOfApprovedOffers);
  }
}
