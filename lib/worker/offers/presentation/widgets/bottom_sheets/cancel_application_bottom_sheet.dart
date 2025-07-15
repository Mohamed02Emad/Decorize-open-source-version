import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/validator.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:decorizer/worker/offers/presentation/cubit/delete_worker_offer_cubit/delete_worker_offer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/di/injection_container.dart';
import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/util/ui_helper.dart';
import 'cancel_application_success_bottom_sheet.dart';


class CancelApplicationBottomSheet extends StatefulWidget {
  const CancelApplicationBottomSheet._({required this.offerId, this.onRefresh});
  final int offerId;
  final Function()? onRefresh;

  static void show({
    required BuildContext context,
    required int offerId,
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
        return CancelApplicationBottomSheet._(offerId:offerId , onRefresh: onRefresh);
      },
    );
  }

  @override
  State<CancelApplicationBottomSheet> createState() => _CancelApplicationBottomSheetState();
}

class _CancelApplicationBottomSheetState extends State<CancelApplicationBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => sl<DeleteWorkerOfferCubit>(),
      child: Builder(
        builder: (context) => _cancelForm(context),
      )
    );
  }

  Widget _cancelForm(BuildContext context) {
    final cubit = context.read<DeleteWorkerOfferCubit>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      AppImage(path: Assets.image.png.cancel.path),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr(LocaleKeys.bottomSheet_cancel_request_header),
                        style: TextStyles.semiBold16(),
                      ),
                      SizedBox(height: 20.h),
                      AppTextField(
                        title: context.tr(LocaleKeys.bottomSheet_cancellation_reason),
                        hint: '',
                        validator: (value) => Validator.comment(value),
                        inputType: TextInputType.text,
                        maxLines: 4,
                        controller: cubit.cancelController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: BlocConsumer<DeleteWorkerOfferCubit, DeleteWorkerOfferState>(
                              listener: (context, state) {
                                state.deleteWorkerOfferState.listen(
                                  onSuccess: (data, message) {
                                    showSuccessToast(data);
                                    widget.onRefresh?.call();
                                    _closeCancelApplicationBottomSheet(context);
                                    _showCancelApplicationSuccessBottomSheet(context);
                                  },
                                  onError: showErrorToast,
                                );
                              },
                              builder: (context, state) => AppButton(
                                backgroundColor: context.appColors.red,
                                text: context.tr(LocaleKeys.action_cancel_request),
                                onClick: () => _submitCancelForm(context),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: AppButton(
                              text: context.tr(LocaleKeys.action_cancel),
                              isBordered: true,
                              backgroundColor: context.appColors.onBackground,
                              borderColor: context.appColors.primary,
                              textColor: context.appColors.primary,
                              onClick: _closeCancelApplicationBottomSheet,
                            ),
                          ),
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
      ),
    );
  }

    void _showCancelApplicationSuccessBottomSheet(BuildContext context){
      CancelApplicationSuccessBottomSheet.show(
        context: context,
        onRefresh: widget.onRefresh,
      );
    }
    void _submitCancelForm(BuildContext context) async {
      if (formKey.currentState?.validate() ?? false) {
        context.read<DeleteWorkerOfferCubit>().deleteWorkerOffer(widget.offerId.toString());
      }
    }

    void _closeCancelApplicationBottomSheet(BuildContext context) {
      Navigator.pop(context);
    }
  }
