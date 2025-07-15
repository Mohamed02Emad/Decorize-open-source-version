import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/paging/paginated_list_view.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/applied_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAllOffersBottomSheet extends StatelessWidget {
  const ShowAllOffersBottomSheet._({required this.orderStatus});
  final OrderDetailsState orderStatus;

  static Future<void> show(BuildContext ctx, {required OrderDetailsState orderStatus}) async {
    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: ctx.read<GetOrderOffersCubit>(),
          child: Container(
            decoration: BoxDecoration(
              color: ctx.appColors.onBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 0.68,
              minChildSize: 0.4,
              maxChildSize: 0.7,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ShowAllOffersBottomSheet._(orderStatus: orderStatus);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final getOrderOffersCubit = context.read<GetOrderOffersCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.order_details_offers_title.tr(),
          style: TextStyles.semiBold14(),
        ).marginTop(12.h),
        Divider(
          height: 4,
          color: context.appColors.grey_3,
        ).marginVertical(12.h),
        Expanded(
          child: PaginatedListView(
            pagingController: getOrderOffersCubit.paginateController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            separator: (_) => Divider(
              height: 2,
              color: context.appColors.grey_3.withValues(alpha: 0.5),
            ).marginVertical(10.h),
            itemBuilder: (context, item, index) {
              return AppliedOfferCard(offer: item, orderStatus: orderStatus);
            },
          ),
        ),
      ],
    );
  }
}
