import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/widget/app_title_bar.dart';
import '../../../offers/domain/Enum/worker_offer_state.dart';
import '../../../offers/presentation/cubit/get_worker_offers/get_worker_offer_cubit.dart';
import '../cubit/get_order_details/get_worker_order_details_cubit.dart';
import '../widgets/bottom_sheets/application_buttom_sheet.dart';
import '../widgets/worker_order_action_button.dart';
import '../widgets/worker_cancellation_button_widget.dart';
import '../widgets/worker_order_details_info_widget.dart';
import '../widgets/worker_order_header_widget.dart';
import '../widgets/worker_order_location_widget.dart';

class WorkerOrderDetailsScreen extends StatelessWidget {
  const WorkerOrderDetailsScreen(
      {super.key, required this.orderId, required this.offerState, this.cancelOfferId});
  final int orderId;
  final int? cancelOfferId;
  final WorkerOfferState? offerState;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<WorkerOrderDetailsCubit>()..getWorkerOrderDetails(orderId),
          ),
          BlocProvider(
            create: (context) => sl<GetWorkerOffersCubit>(),
          ),
        ],
        child: _WorkerOrderDetailsScreen(
            orderId: orderId, offerState: offerState, cancelOfferId: cancelOfferId,));
  }
}

class _WorkerOrderDetailsScreen extends StatelessWidget {
  final int orderId;
  final int? cancelOfferId;
  final WorkerOfferState? offerState;
  _WorkerOrderDetailsScreen(
      {required this.orderId, required this.offerState, super.key, this.cancelOfferId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppTitleBar(
          title: 'order_details.title'.tr(),
          hasBackButton: true,
        ),
        body: RefreshIndicator.adaptive(
          color: context.appColors.primary,
          onRefresh: () async {
            _refresh(context);
          },
          child: BlocConsumer<WorkerOrderDetailsCubit, WorkerOrderDetailsState>(
            listener: (context, state) =>
                state.orderDetailsState.listen(
                  onSuccess: (data, message) {
                    context.read<GetWorkerOffersCubit>().init(
                        orderId, data.status);
                  },
                ),
            builder: (context, state) =>
                state.orderDetailsState.build(
                  successBuilder: (orderDetails) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WorkerOrderHeaderWidget(
                            orderDetails: orderDetails,
                          ),
                          WorkerOrderDetailsInfoWidget(
                              orderDetails: orderDetails),
                          WorkerOrderLocationWidget(
                            orderDetails: orderDetails,
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: _showBottomNavigationButton(context));
  }
  Widget  _showBottomNavigationButton(BuildContext context ) {
    switch (offerState) {
      case WorkerOfferState.cancelled:
      case WorkerOfferState.rejected:
      case WorkerOfferState.approved:
        return const SizedBox.shrink();
      case WorkerOfferState.pending:
        return WorkerCancellationButtonWidget(
          offerId: cancelOfferId ?? orderId,
          onRefresh: () => _refresh(context),
        );
      case null:
        return WorkerOrderActionButtonWidget(
          onAccept: () => _onAccept(context),
        );
    }
  }

  void _refresh(BuildContext context) {
    context.read<WorkerOrderDetailsCubit>().getWorkerOrderDetails(orderId);
  }

  void _onAccept(BuildContext context) {
    ApplicationBottomSheet.show(
        context: context,
        postId: orderId,
        onRefresh: () async {
          _refresh(context);
        });
  }
}
