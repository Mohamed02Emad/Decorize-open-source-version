import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/theme/color/app_colors.dart';
import '../../../../common/widget/animations/fade.dart';
import '../../../../common/widget/animations/slide.dart';

class RatesWidget extends StatelessWidget {
  const RatesWidget(
      {super.key, required this.ratesDistribution, required this.avgRates});
  final Map<String, dynamic> ratesDistribution;
  final double avgRates;

  @override
  Widget build(BuildContext context) {
    final List<int> distributionList = List.generate(
      5,
      (index) => ratesDistribution['${index + 1}']?.toString().toInt() ?? 0,
    );

    final int total = distributionList.reduce((a, b) => a + b);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(avgRates.toStringAsFixed(1), style: TextStyles.bold18()),
            6.gap,
            Text("${LocaleKeys.common_of.tr()} 5",
                style: TextStyles.regular11(color: context.appColors.hintText)),
            const Spacer(),
            Row(
              children: List.generate(5, (index) {
                return SlideWrapper(
                  slideDirection: SlideDirection.down,
                  startAnimationDelay: Duration(milliseconds: 60 * (index)),
                  initialOffset: 15,
                  child: Icon(
                      (index < avgRates.floor())
                          ? Icons.star_rounded
                          : (index == avgRates.floor() && avgRates % 1 != 0)
                              ? Icons.star_half_rounded
                              : Icons.star_border_rounded,
                      size: 18.w,
                      color: AppColors.yellow),
                );
              }),
            ),
          ],
        ),
        if (ratesDistribution.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    return Row(
                      children: [
                        Text("${index + 1}", style: TextStyles.regular14()),
                        4.gap,
                        Icon(Icons.star_rounded,
                            size: 15.w, color: AppColors.yellow),
                        8.gap,
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 7.h,
                            decoration: BoxDecoration(
                                color: context.appColors.primary
                                    .withValues(alpha: 0.12),
                                borderRadius: 6.borderRadius),
                            child: FadeAppearWrapper(
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                    begin: 0,
                                    end: (total == 0
                                        ? 0
                                        : (distributionList[index] / total))),
                                duration: Duration(milliseconds: 1200),
                                curve: Curves.fastEaseInToSlowEaseOut,
                                builder: (context, value, child) {
                                  return FractionallySizedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    widthFactor: value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: context.appColors.primary,
                                        borderRadius: 6.borderRadius,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Center(
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                  begin:
                                      (distributionList[index] / total * 100) /
                                          2,
                                  end: (distributionList[index] / total * 100)),
                              curve: Curves.easeInSine,
                              duration: Duration(milliseconds: 1200),
                              builder: (context, value, child) {
                                return Text(
                                  "${value.toStringAsFixed(0)}%",
                                  style: TextStyles.regular12(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ).marginTop(6.h),
      ],
    );
  }
}
