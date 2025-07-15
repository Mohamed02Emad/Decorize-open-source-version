import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:decorizer/common/widget/dialogs/action_dialog.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/create_chat_params.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/create_chat/create_chat_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/pages/chat_details_screen.dart';
import 'package:decorizer/user/orders/domain/enums/offer_state.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/offer_model.dart';
import 'package:decorizer/user/orders/presentation/cubits/update_offer_status/update_offer_status_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/bottom_sheets/rate_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/add_rate/add_rate_cubit.dart';

class AppliedOfferCard extends StatelessWidget {
  AppliedOfferCard(
      {super.key,
      required this.offer,
      this.onOfferUpdated,
      required this.orderStatus});
  final OfferModel offer;
  final OrderDetailsState orderStatus;
  final Function(OfferModel)? onOfferUpdated;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UpdateOfferStatusCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CreateChatCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<AddRateCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            _openWorkerProfile(context);
          },
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImage(
                    path: offer.user.image,
                    width: 46.w,
                    height: 46.h,
                    radius: 46.r,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.user.name,
                        style: TextStyles.semiBold12(),
                      ),
                      5.gap,
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16.sp,
                            color: AppColors.yellow,
                          ),
                          Text(
                            (offer.user.avgRating ?? 0.0).toStringAsFixed(1),
                            style: TextStyles.semiBold12(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        offer.user.profession ?? '',
                        style: TextStyles.semiBold12(
                            color: context.appColors.primary),
                      ),
                      5.gap,
                      Text(
                        offer.budget.toStringAsFixed(1).currency,
                        style: TextStyles.semiBold12(
                            color: context.appColors.primary),
                      ),
                    ],
                  ),
                  if (offer.status.isChatAvailable &&
                      !orderStatus.isCancelled &&
                      !orderStatus.isCompleted)
                    Align(
                      alignment: Alignment.center,
                      child: BlocConsumer<CreateChatCubit, CreateChatState>(
                        listener: (context, state) {
                          state.createChatState.listen(
                            onError: showErrorToast,
                            onSuccess: (data, message) =>
                                _openChat(context, data),
                          );
                        },
                        builder: (context, state) => Container(
                          padding: 10.edgeInsetsAll,
                          decoration: BoxDecoration(
                            color: context.appColors.primary
                                .withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: state.createChatState.isLoading
                              ? AppLoading(
                                  size: 14.sp,
                                )
                              : Icon(
                                  Icons.chat_rounded,
                                  color: context.appColors.white,
                                  size: 14.sp,
                                ),
                        ).clickable(() {
                          _createChat(context);
                        }, radius: 30.r).marginStart(12.w),
                      ),
                    ),
                  if (orderStatus.isCompleted)
                   Icon(
                        Icons.star_border_rounded,
                         color: Colors.amber,
                         size: 20.sp,
                       ).clickable(() {
                         _openRateBottomSheet(context, offer.user.id) ;
                       }, radius: 30.r).marginStart(12.w),
                ],
              ),
              DynamicContainer(
                showChild: orderStatus.isPending,
                child: switch (offer.status) {
                  OfferState.pending =>
                    _OfferButtons(offer: offer, onOfferUpdated: onOfferUpdated),
                  OfferState.approved =>
                    _buildOfferStatusText(OfferState.approved),
                  OfferState.rejected =>
                    _buildOfferStatusText(OfferState.rejected),
                  OfferState.cancelled =>
                    _buildOfferStatusText(OfferState.cancelled),
                },
              ),
              _buildOfferInfoSection(context),
            ],
          ),
        );
      }),
    );
  }

  final ValueNotifier<bool> isOfferInfoExpanded = ValueNotifier(false);
  Widget _buildOfferInfoSection(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isOfferInfoExpanded,
      builder: (context, isExpanded, child) => Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${isExpanded ? LocaleKeys.order_details_hide_offer_details.tr() : LocaleKeys.order_details_show_offer_details.tr()} :',
                style: TextStyles.semiBold12(),
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 24.sp,
                color: context.appColors.primary,
              ),
            ],
          ).clickable(() {
            isOfferInfoExpanded.value = !isOfferInfoExpanded.value;
          }),
          DynamicContainer(
            showChild: isExpanded,
            child: Column(
              children: [
                _buildDetailRow(
                  context: context,
                  label: '${LocaleKeys.order_details_number_of_days.tr()} :',
                  value: offer.numberOfDays.toString(),
                  valueColor: context.appColors.text,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${LocaleKeys.order_details_worker_cover_letter.tr()} :',
                      style: TextStyles.regular12().copyWith(
                        color: context.appColors.grey_2,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      offer.description,
                      style: TextStyles.regular12(),
                    )),
                  ],
                )
              ],
            ),
          )
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

  Widget _buildOfferStatusText(OfferState status) {
    return Center(
        child: Text(
      status.name.tr(),
      style: TextStyles.semiBold12(color: status.color),
    ));
  }

  void _openWorkerProfile(BuildContext context) {
    showSuccessToast(offer.user.name);
  }

  void _openChat(BuildContext context, ChatModel chatModel) {
    Nav.push(
      ChatDetailsScreen(
        chatModel: chatModel,
      ),
    );
  }

  void _createChat(BuildContext context) {
    context.read<CreateChatCubit>().createChat(CreateChatParams(
          userId: offer.user.id.toString(),
        ));
  }

  void _openRateBottomSheet(BuildContext context, int id) {
    RateBottomSheet.show(
      context: context,
      id: id,
    );
  }
}

class _OfferButtons extends StatelessWidget {
  const _OfferButtons({super.key, required this.offer, this.onOfferUpdated});
  final Function(OfferModel)? onOfferUpdated;
  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: BlocConsumer<UpdateOfferStatusCubit, UpdateOfferStatusState>(
          listenWhen: (previous, current) =>
              previous.acceptOfferState != current.acceptOfferState,
          buildWhen: (previous, current) =>
              previous.acceptOfferState != current.acceptOfferState,
          listener: (context, state) => state.acceptOfferState.listen(
            onError: showErrorToast,
            onSuccess: (data, message) => _onAcceptOfferSuccess(context),
          ),
          builder: (context, state) => AppButton.small(
            isLoading: state.acceptOfferState.isLoading,
            text: LocaleKeys.action_accept.tr(),
            height: 34.h,
            onClick: () {
              _acceptOffer(context);
            },
          ),
        )),
        12.gap,
        Expanded(
            child: BlocConsumer<UpdateOfferStatusCubit, UpdateOfferStatusState>(
          listenWhen: (previous, current) =>
              previous.rejectOfferState != current.rejectOfferState,
          buildWhen: (previous, current) =>
              previous.rejectOfferState != current.rejectOfferState,
          listener: (context, state) => state.rejectOfferState.listen(
            onError: showErrorToast,
            onSuccess: (data, message) => _onRejectOfferSuccess(context),
          ),
          builder: (context, state) => AppButton.small(
            text: LocaleKeys.action_reject.tr(),
            isLoading: state.rejectOfferState.isLoading,
            height: 34.h,
            backgroundColor: context.appColors.onBackground,
            borderColor: context.appColors.red,
            textColor: context.appColors.red,
            isBordered: true,
            onClick: () {
              _rejectOffer(context);
            },
          ),
        )),
      ],
    ).marginTop(8.h);
  }

  void _acceptOffer(BuildContext context) {
    ActionDialog.show(
      context,
      title: LocaleKeys.action_accept.tr(),
      message: LocaleKeys.order_details_accept_offer_message.tr(),
      positiveText: LocaleKeys.action_accept.tr(),
      negativeText: LocaleKeys.action_cancel.tr(),
      onPositiveClicked: () {
        context.read<UpdateOfferStatusCubit>().acceptOffer(
              offerId: offer.id.toString(),
            );
      },
    );
  }

  void _rejectOffer(BuildContext context) {
    ActionDialog.show(
      context,
      title: LocaleKeys.action_reject.tr(),
      message: LocaleKeys.order_details_reject_offer_message.tr(),
      positiveText: LocaleKeys.action_reject.tr(),
      negativeText: LocaleKeys.action_cancel.tr(),
      onPositiveClicked: () {
        context.read<UpdateOfferStatusCubit>().rejectOffer(
              offerId: offer.id.toString(),
            );
      },
    );
  }

  void _onAcceptOfferSuccess(BuildContext context) {
    final updatedOffer = offer.updateStatus(OfferState.approved);
    onOfferUpdated?.call(updatedOffer);
  }

  void _onRejectOfferSuccess(BuildContext context) {
    final updatedOffer = offer.updateStatus(OfferState.rejected);
    onOfferUpdated?.call(updatedOffer);
  }
}
