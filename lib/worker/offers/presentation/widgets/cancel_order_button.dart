import 'package:decorizer/worker/offers/presentation/widgets/bottom_sheets/cancel_application_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CancelButton extends StatefulWidget{

  const CancelButton({super.key,
    required this.offerId,
    this.onRefresh,});
  final int offerId;
  final Function()? onRefresh;
  @override
  State<CancelButton> createState() {
    return _CancelButton();
  }
}

class _CancelButton extends State<CancelButton>{


  @override
  Widget build(BuildContext context) {
    return AppButton.small(
      backgroundColor: context.appColors.onBackground,
      isBordered: true,
      borderColor: context.appColors.red,
        height: 36.h,
        text: context.tr(LocaleKeys.OrderScreen_cancel),
        onClick: ()=> _opnCancelApplicationBottomSheet(context),
    );
  }
  void _opnCancelApplicationBottomSheet(BuildContext context) {
    CancelApplicationBottomSheet.show(
      context: context,
      offerId: widget.offerId,
      onRefresh: widget.onRefresh,
    );
  }
}
