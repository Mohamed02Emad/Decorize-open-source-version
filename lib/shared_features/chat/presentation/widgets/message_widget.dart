import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/datetime_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/shared_features/chat/domain/enums/message_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constant/textStyles.dart';
import '../../domain/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final bool isMine;
  final MessageModel messageModel;

  MessageWidget({super.key, required this.isMine, required this.messageModel});

  final ValueNotifier<bool> isDateExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(!isMine ? 1 : -1, 0),
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(6.h),
            decoration: BoxDecoration(
              color: messageModel.status == MessageStatus.sending
                  ? context.appColors.grey_2
                  : isMine
                      ? context.appColors.primary
                      : context.appColors.onBackground,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: 12.r.radius,
                topStart: 12.r.radius,
                bottomEnd: isMine ? 12.r.radius : 0.radius,
                bottomStart: !isMine ? 12.r.radius : 0.radius,
              ),
              boxShadow: !isMine ? context.boxShadow : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    '${messageModel.message}',
                    style: TextStyles.regular12(
                        color: isMine
                            ? context.appColors.white
                            : context.appColors.text),
                  ).paddingAll(6.h),
                ),
              ],
            ),
          ),
          2.gap,
          ValueListenableBuilder(
            valueListenable: isDateExpanded,
            builder: (context, isDateExpanded, child) => DynamicContainer(
              showChild: isDateExpanded,
              child: Text(
                messageModel.createdAt?.dateDdMmYyyyHhMm ?? '',
                style: TextStyles.regular12(color: context.appColors.text)
                    .copyWith(fontSize: 9.sp),
              ),
            ),
          ),
        ],
      ),
    )
        .clickable(
          () {
            isDateExpanded.value = !isDateExpanded.value;
          },
          color: Colors.transparent,
        )
        .marginHorizontal(8.h)
        .marginBottom(4.h)
        .marginEnd(!isMine ? 0 : context.deviceWidth * 0.3)
        .marginStart(isMine ? 0 : context.deviceWidth * 0.3);
  }
}
