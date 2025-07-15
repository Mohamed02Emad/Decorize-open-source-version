import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/app/app_button.dart';

class WorkerOrderActionButtonWidget extends StatelessWidget {
  final VoidCallback? onAccept;
  const WorkerOrderActionButtonWidget({
    super.key,
    this.onAccept,
  });
  @override
  Widget build(BuildContext context) {
    return  FloatingCard(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child:  AppButton(text: context.tr(LocaleKeys.home_apply_now), onClick: onAccept),
    );
  }
}
