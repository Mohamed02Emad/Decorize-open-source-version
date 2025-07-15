import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/custom_selection_field.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOrdersBottomSheet extends StatelessWidget {
  FilterOrdersBottomSheet._({this.initialStatus, required this.onApply});
  final OrderDetailsState? initialStatus;
  final Function(OrderDetailsState? status) onApply;

  static Future<void> show(BuildContext context,
      {required OrderDetailsState? initialStatus,
      required Function(OrderDetailsState? status) onApply}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => FilterOrdersBottomSheet._(
            initialStatus: initialStatus, onApply: onApply));
  }

  OrderDetailsState? currentStatus;

  @override
  Widget build(BuildContext context) {
    currentStatus = initialStatus;
    return SizedBox(
      height: 300.h,
      child: Column(
        children: [
          16.gap,
          Text(
            LocaleKeys.common_filter.tr(),
            style: TextStyles.semiBold14(),
          ),
          12.gap,
          CustomSelectionField(
            title: LocaleKeys.common_status.tr(),
            hint: LocaleKeys.common_all.tr(),
            initialValue: initialStatus,
            futureRequest: () async => OrderDetailsState.values.toList(),
            itemToString: (item) => item?.displayName.tr() ?? '',
            onChanged: (value) {
              currentStatus = value;
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: LocaleKeys.common_apply.tr(),
                  onClick: () {
                    Nav.pop(context);
                    onApply(currentStatus);
                  },
                ),
              ),
              16.gap,
              Expanded(
                child: AppButton(
                  text: LocaleKeys.common_clear.tr(),
                  backgroundColor: context.appColors.background,
                  textColor: context.appColors.primary,
                  borderColor: context.appColors.primary,
                  isBordered: true,
                  onClick: () {
                    Nav.pop(context);
                    onApply(null);
                  },
                ),
              ),
            ],
          ),
          46.gap,
        ],
      ).marginHorizontal(16.w),
    );
  }
}
