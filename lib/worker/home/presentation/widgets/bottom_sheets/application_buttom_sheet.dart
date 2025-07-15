import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/validator.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:decorizer/worker/home/presentation/cubit/store_offer/store_offer_cubit.dart';
import 'package:decorizer/worker/home/presentation/widgets/bottom_sheets/application_success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/di/injection_container.dart';
import '../../../../../common/util/ui_helper.dart';

class ApplicationBottomSheet extends StatefulWidget {
  const ApplicationBottomSheet._({required this.postId, this.onRefresh});
  final int postId;
  final Function()? onRefresh;

  static void show({
    required BuildContext context,
    required int postId,
    Function()? onRefresh,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ApplicationBottomSheet._(postId: postId, onRefresh: onRefresh);
      },
    );
  }

  @override
  State<ApplicationBottomSheet> createState() => _ApplicationBottomSheetState();
}

class _ApplicationBottomSheetState extends State<ApplicationBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<StoreOfferCubit>(),
        child: Builder(builder: (context) => _applicationForm(context)));
  }

  Widget _applicationForm(BuildContext context) {
    final cubit = context.read<StoreOfferCubit>();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsetsDirectional.only(
            start: 20.w,
            end: 20.w,
            top: 20.h,
            bottom: 20.h,
          ),
          child: Wrap(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      context.tr(LocaleKeys.bottomSheet_request_submission),
                      style: TextStyles.semiBold16(),
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                        title: context.tr(LocaleKeys.bottomSheet_service_price),
                        hint: '',
                        validator: (value) => Validator.servicePrice(value),
                        inputType: TextInputType.number,
                        suffixIcon: Text(
                          context.tr(LocaleKeys.Currency_egp),
                          style: TextStyles.regular12(
                              color: context.appColors.hintText
                                  .withValues(alpha: 0.8)),
                        ).marginLeft(8.w).marginTop(10.h),
                        controller: cubit.servicePriceController),
                    SizedBox(height: 12.h),
                    AppTextField(
                        title: context.tr(LocaleKeys.bottomSheet_duration),
                        hint: '',
                        validator: (value) =>
                            Validator.estimatedDuration(value),
                        inputType: TextInputType.number,
                        controller: cubit.estimatedDurationController),
                    SizedBox(height: 12.h),
                    AppTextField(
                        title: context.tr(LocaleKeys.action_add_comment),
                        hint: '',
                        maxLines: 3,
                        controller: cubit.commentController,
                        validator: (value) => Validator.comment(value)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        BlocConsumer<StoreOfferCubit, StoreOfferState>(
                          listener: (context, state) {
                            state.storeOffer.listen(
                              onSuccess: (data, message) {
                                showSuccessToast(data);
                                widget.onRefresh?.call();
                                _closeApplicationBottomSheet(context);
                                _showApplicationSuccessBottomSheet(context);
                              },
                              onError: showErrorToast,
                            );
                          },
                          builder: (context, state) => Expanded(
                            child: AppButton(
                              isLoading: state.storeOffer.isLoading,
                              text:
                                  context.tr(LocaleKeys.action_submit_request),
                              onClick: () => _submitApplicationForm(context),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                            child: AppButton(
                                text: context.tr(LocaleKeys.action_close),
                                isBordered: true,
                                backgroundColor: context.appColors.onBackground,
                                borderColor: context.appColors.primary,
                                textColor: context.appColors.primary,
                                onClick: () =>
                                    _closeApplicationBottomSheet(context)))
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitApplicationForm(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      context.read<StoreOfferCubit>().storeOffer(widget.postId);
    }
  }

  void _showApplicationSuccessBottomSheet(BuildContext context) {
    ApplicationSuccessBottomSheet.show(
      context: context,
    );
  }

  void _closeApplicationBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
