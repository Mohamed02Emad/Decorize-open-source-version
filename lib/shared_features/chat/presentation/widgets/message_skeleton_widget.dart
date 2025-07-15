import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageSkeletonWidget extends StatelessWidget {
  final bool isMine;

  const MessageSkeletonWidget({super.key, required this.isMine});

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
              color: isMine
                  ? context.appColors.primary.withOpacity(0.1)
                  : context.appColors.onBackground.withOpacity(0.1),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: 12.r.radius,
                topStart: 12.r.radius,
                bottomEnd: isMine ? 12.r.radius : 0.radius,
                bottomStart: !isMine ? 12.r.radius : 0.radius,
              ),
              boxShadow: !isMine ? context.boxShadow : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message text skeleton
                  Skeleton(
                    width: _getRandomMessageWidth(context),
                    height: 14.h,
                    radius: 4.r,
                  ),
                  // Sometimes add a second line for longer messages
                  if (_shouldShowSecondLine())
                    Column(
                      children: [
                        4.gap,
                        Skeleton(
                          width: _getRandomSecondLineWidth(context),
                          height: 14.h,
                          radius: 4.r,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          2.gap,
          // Date skeleton
          Skeleton(
            width: 60.w,
            height: 9.h,
            radius: 2.r,
          ),
        ],
      ),
    )
        .marginHorizontal(8.h)
        .marginBottom(4.h)
        .marginEnd(!isMine ? 0 : context.deviceWidth * 0.3)
        .marginStart(isMine ? 0 : context.deviceWidth * 0.3);
  }

  double _getRandomMessageWidth(BuildContext context) {
    // Generate different widths to simulate various message lengths
    final baseWidth = context.deviceWidth * 0.4;
    final variations = [0.6, 0.8, 1.0, 1.2];
    final randomIndex = (DateTime.now().millisecond ~/ 250) % variations.length;
    return baseWidth * variations[randomIndex];
  }

  double _getRandomSecondLineWidth(BuildContext context) {
    // Shorter width for second line
    final baseWidth = context.deviceWidth * 0.3;
    final variations = [0.5, 0.7, 0.9];
    final randomIndex = (DateTime.now().millisecond ~/ 333) % variations.length;
    return baseWidth * variations[randomIndex];
  }

  bool _shouldShowSecondLine() {
    // Randomly show second line for some messages to simulate variety
    return (DateTime.now().millisecond ~/ 500) % 3 == 0;
  }
}
