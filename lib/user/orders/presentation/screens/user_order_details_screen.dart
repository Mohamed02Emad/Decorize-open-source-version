import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/intent_util.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/actions_menu.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/common/widget/dialogs/action_dialog.dart';
import 'package:decorizer/user/create_ad/presentation/pages/upsert_ad_screen.dart';
import 'package:decorizer/user/orders/presentation/widgets/dialogs/cancel_order_dialog.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/common/widget/location_map.dart';
import 'package:decorizer/user/orders/presentation/cubits/delete_user_order/delete_user_order_cubit.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit.dart';
import 'package:decorizer/user/orders/presentation/cubits/update_order_status/update_order_status_cubit.dart';
import 'package:decorizer/user/orders/presentation/cubits/user_order_details/user_order_details_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/order_details_info_widget.dart';
import 'package:decorizer/user/orders/presentation/widgets/order_header_widget.dart';
import 'package:decorizer/user/orders/presentation/widgets/user_order_details_bottom_nav.dart';
import 'package:decorizer/user/orders/presentation/widgets/user_order_offers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserOrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const UserOrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetOrderOffersCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DeleteUserOrderCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateOrderStatusCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              sl<UserOrderDetailsCubit>()..getUserOrderDetails(orderId),
        ),
      ],
      child: _UserOrderDetailsScreenBody(orderId: orderId),
    );
  }
}

class _UserOrderDetailsScreenBody extends StatelessWidget {
  final int orderId;
  const _UserOrderDetailsScreenBody({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: 'order_details.title'.tr(),
        hasBackButton: true,
        actions: BlocBuilder<UserOrderDetailsCubit, UserOrderDetailsState>(
          builder: (context, state) {
            final canDelete =
                state.orderDetailsState.data?.status.isPending == true;
            return DynamicContainer(
              showChild: canDelete,
              child: BlocConsumer<DeleteUserOrderCubit, DeleteUserOrderState>(
                listener: (context, state) => state.deleteUserOrderState.listen(
                  onError: showErrorToast,
                  onSuccess: (data, message) {
                    _onDeleteOrderSuccess(context, message);
                  },
                ),
                builder: (context, deleteState) =>
                    BlocBuilder<UpdateOrderStatusCubit, UpdateOrderStatusState>(
                  builder: (context, updateState) => ActionsMenu(
                    isLoading: deleteState.deleteUserOrderState.isLoading ||
                        updateState.cancelOrderState.isLoading,
                    actions: [
                      ActionMenuItem(
                        title: LocaleKeys.order_details_edit_order.tr(),
                        onTap: () => _onEditOrderClicked(context),
                        icon: Icon(
                          Icons.edit,
                          size: 14.w,
                          color: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                        ),
                      ),
                      ActionMenuItem(
                        title: LocaleKeys.order_details_cancel_order.tr(),
                        onTap: () => _onCancelOrderClicked(context),
                        icon: Icon(
                          Icons.cancel,
                          size: 14.w,
                          color: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                        ),
                      ),
                      ActionMenuItem(
                        title: LocaleKeys.common_delete.tr(),
                        onTap: () => _onDeleteOrderClicked(context),
                        textColor: context.appColors.red,
                        icon: Icon(
                          Icons.delete,
                          size: 14.w,
                          color: context.appColors.red,
                        ),
                      ),
                    ],
                  ).marginEnd(12.w),
                ),
              ),
            );
          },
        ),
      ),
      body: RefreshIndicator.adaptive(
        color: context.appColors.primary,
        onRefresh: () => _refresh(context),
        child: MultiBlocListener(
          listeners: [
            BlocListener<UserOrderDetailsCubit, UserOrderDetailsState>(
              listener: (context, state) => state.orderDetailsState.listen(
                onSuccess: (data, message) {
                  context
                      .read<GetOrderOffersCubit>()
                      .init(orderId, data.status);
                },
              ),
            ),
            BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
              listener: (context, state) => state.cancelOrderState.listen(
                onError: showErrorToast,
                onSuccess: (data, message) {
                  _onCancelOrderSuccess(context, message);
                },
              ),
            ),
          ],
          child: BlocBuilder<UserOrderDetailsCubit, UserOrderDetailsState>(
            builder: (context, state) => state.orderDetailsState.build(
              onRetry: () => _refresh(context),
              successBuilder: (orderDetails) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderHeaderWidget(
                        orderDetails: orderDetails,
                      ),
                      OrderDetailsInfoWidget(
                        orderDetails: orderDetails,
                      ).fadeScaleAppear().marginHorizontal(16.w),
                      // if (orderState.showCancelledMessage)

                      UserOrderOffersSection(
                        orderDetails: orderDetails,
                      ).marginTop(4.h),
                      // if (widget.orderState.showMap)
                      LocationMap(
                        title: orderDetails.locationDescription,
                        latlng: LatLng(
                          orderDetails.lat ?? 0,
                          orderDetails.long ?? 0,
                        ),
                        onClick: () {
                          openMapsApp(
                              orderDetails.lat ?? 0, orderDetails.long ?? 0);
                        },
                      ).marginHorizontal(16.w).marginVertical(12.h),
                      SizedBox(height: 30.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      //todo: show only if has accepted workers
      bottomNavigationBar: UserOrderDetailsBottomNav(),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    await context.read<UserOrderDetailsCubit>().getUserOrderDetails(orderId);
  }

  void _onEditOrderClicked(BuildContext context) {
    final orderDetails =
        context.read<UserOrderDetailsCubit>().state.orderDetailsState.data;
    if (orderDetails != null) {
      Nav.push(UpsertAdScreen(orderDetailsModel: orderDetails)).then((result) {
        if (result != null) {
          // Refresh the screen after update
          _refresh(context);
        }
      });
    }
  }

  void _onDeleteOrderClicked(BuildContext context) {
    ActionDialog.showDeleteDialog(context, onPositiveClicked: () {
      context.read<DeleteUserOrderCubit>().deleteUserOrder(orderId.toString());
    });
  }

  void _onCancelOrderClicked(BuildContext context) {
    CancelOrderDialog.show(
      context,
      onConfirmCancel: (reason) {
        context
            .read<UpdateOrderStatusCubit>()
            .cancelOrder(orderId: orderId.toString(), reason: reason);
      },
    );
  }

  void _onCancelOrderSuccess(BuildContext context, String? message) {
    showSuccessToast(message ?? LocaleKeys.action_success.tr());
    // Refresh the screen to show the updated order status
    _refresh(context);
  }

  void _onDeleteOrderSuccess(BuildContext context, String? message) {
    showSuccessToast(message ?? LocaleKeys.action_success.tr());
    Nav.pop(context, result: {
      "action": "delete_order",
    });
  }
}
