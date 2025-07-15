import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/datetime_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/widget/app/floating_card.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/shared_features/notifications/domain/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            Assets.image.svg.notification.path,
            width: 24.w,
            colorFilter: context.appColors.text.colorFilter,
          ).marginEnd(12.h).marginTop(4.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      notification.title,
                      style: TextStyles.semiBold12(),
                    ).marginBottom(4.h),
                    const Spacer(),
                    Text(
                      notification.createdAt.format(),
                      style: TextStyles.regular10(
                          color: context.appColors.hintText),
                    ).marginBottom(4.h),
                  ],
                ),
                Text(
                  notification.body,
                  style: TextStyles.regular12(
                      color: context.appColors.text.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
