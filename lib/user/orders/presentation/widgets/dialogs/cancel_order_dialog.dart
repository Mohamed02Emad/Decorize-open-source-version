import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common.dart';
import '../../../../../common/widget/app/app_button.dart';

class CancelOrderDialog extends StatefulWidget {
  final Function(String? reason) onConfirmCancel;
  final Function()? onCancelClicked;

  const CancelOrderDialog._({
    required this.onConfirmCancel,
    this.onCancelClicked,
  });

  static void show(
    BuildContext context, {
    required Function(String? reason) onConfirmCancel,
    Function()? onCancelClicked,
  }) {
    showDialog(
      context: context,
      builder: (context) => CancelOrderDialog._(
        onConfirmCancel: onConfirmCancel,
        onCancelClicked: onCancelClicked,
      ),
    );
  }

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scaledRadius = 12.h;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaledRadius),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      elevation: 0,
      backgroundColor: context.appColors.onBackground,
      child: Material(
        borderRadius: BorderRadius.circular(scaledRadius),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: context.appColors.onBackground,
            borderRadius: BorderRadius.circular(scaledRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              12.h.gap,
              Text(
                LocaleKeys.order_details_cancel_order.tr(),
                textAlign: TextAlign.center,
                style: TextStyles.bold18(context: context),
              ).marginStart(12.w),
              SizedBox(height: 12.h),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.order_details_cancel_order_message.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyles.semiBold14(
                        context: context,
                        color: context.appColors.hintText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Reason text field
              AppTextField(
                controller: _reasonController,
                hint: LocaleKeys.bottomSheet_cancellation_reason.tr(),
                title: LocaleKeys.order_details_cancelation_reason.tr(),
                maxLines: 3,
                minLines: 2,
                inputType: TextInputType.multiline,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 16.h),
                  Expanded(
                    child: AppButton.small(
                      text: LocaleKeys.action_cancel.tr(),
                      isBordered: true,
                      borderColor: context.appColors.text,
                      height: 40.h,
                      backgroundColor: context.appColors.onBackground,
                      onClick: () {
                        Navigator.pop(context);
                        widget.onCancelClicked?.call();
                      },
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: AppButton.small(
                      rippleColor: context.appColors.red.withValues(alpha: 0.2),
                      text: LocaleKeys.order_details_cancel_order.tr(),
                      textColor: Colors.white,
                      height: 40.h,
                      onClick: () async {
                        Navigator.pop(context);
                        widget.onConfirmCancel(
                            _reasonController.text.trim().isEmpty
                                ? null
                                : _reasonController.text.trim());
                      },
                      isWrapContent: true,
                      backgroundColor: context.appColors.red,
                      borderColor: context.appColors.onBackground,
                    ),
                  ),
                  SizedBox(width: 16.h),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
