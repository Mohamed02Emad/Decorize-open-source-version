import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/user/orders/presentation/cubits/update_order_status/update_order_status_cubit.dart';
import 'package:decorizer/user/orders/presentation/cubits/user_order_details/user_order_details_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/bottom_sheets/rate_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrderDetailsBottomNav extends StatelessWidget {
  const UserOrderDetailsBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderDetailsCubit, UserOrderDetailsState>(
      builder: (context, state) {
        final orderDetails = state.orderDetailsState.data;
        final isPending = orderDetails?.status.isPending == true;
        final hasAcceptedOffers = (orderDetails?.acceptedOffersCount ?? 0) > 0;
        if (isPending && hasAcceptedOffers) {
          return BlocConsumer<UpdateOrderStatusCubit, UpdateOrderStatusState>(
            buildWhen: (previous, current) =>
                previous.startWorkState != current.startWorkState,
            listenWhen: (previous, current) =>
                previous.startWorkState != current.startWorkState,
            listener: (context, state) {
              state.startWorkState.listen(
                  onSuccess: (data, message) {
                    _refreshOrderDetails(context, orderDetails!.id);
                  },
                  onError: showErrorToast);
            },
            builder: (context, state) {
              return AppButton(
                text: LocaleKeys.order_details_start_with_accepted_workers.tr(),
                onClick: () {
                  _startWithAcceptedWorkers(context, orderDetails!.id);
                },
                margin: 16.edgeInsetsHorizontal.copyWith(bottom: 30.h),
              );
            },
          );
        }
        final isOrderCanceled = orderDetails?.status.isCancelled == true;
        if (isOrderCanceled) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.order_details_order_canceled.tr(),
                style: TextStyles.semiBold12(
                    context: context, color: AppColors.red),
              ),
            ],
          );
        }
           final isOrderInProgress = orderDetails?.status.isInProgress == true;
        if (isOrderInProgress) {
          return BlocConsumer<UpdateOrderStatusCubit, UpdateOrderStatusState>(
            buildWhen: (previous, current) =>
                previous.endWorkState != current.endWorkState,
            listenWhen: (previous, current) =>
                previous.endWorkState != current.endWorkState,
            listener: (context, state) {
              state.endWorkState.listen(
                  onSuccess: (data, message) {
                    showSuccessToast(message ??
                        LocaleKeys.order_details_complete_order_success.tr());
                    _refreshOrderDetails(context, orderDetails!.id);
                  },
                  onError: showErrorToast);
            },
            builder: (context, state) {
              return AppButton(
                isLoading: state.endWorkState.isLoading,
                text: LocaleKeys.order_details_complete_order.tr(),
                onClick: () {
                  _completeOrder(context, orderDetails!.id);
                },
                margin: 16.edgeInsetsHorizontal.copyWith(bottom: 30.h),
              );
            },
          );
        }
        // final isOrderCompleted = orderDetails?.status.isCompleted == true;
        // if (isOrderCompleted) {
        //   return AppButton(
        //     text: LocaleKeys.order_details_rate_workers.tr(),
        //     onClick: () {
        //       _rateWorkers(context, orderDetails!.id);
        //     },
        //     margin: 16.edgeInsetsHorizontal.copyWith(bottom: 30.h),
        //   );
        // }

        return const SizedBox.shrink();
      },
    );
  }

  void _startWithAcceptedWorkers(BuildContext context, int id) {
    context.read<UpdateOrderStatusCubit>().startWork(orderId: id.toString());
  }

  void _rateWorkers(BuildContext context, int id) {
  }

  void _refreshOrderDetails(BuildContext context, int id) {
    context.read<UserOrderDetailsCubit>().getUserOrderDetails(id);
  }

  void _completeOrder(BuildContext context, int id) {
    context.read<UpdateOrderStatusCubit>().endWork(orderId: id.toString());
  }
}
