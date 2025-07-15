import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/user/view_worker_profile/presentation/widgets/rates_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatesAndCommentsSection extends StatelessWidget {
  const RatesAndCommentsSection(
      {super.key, required this.ratesDistribution, required this.avgRates});

  final Map<String, dynamic> ratesDistribution;
  final double avgRates;

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
        margin:
            EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 0.h),
        radius: 12.r,
        child: Column(
          children: [
            RatesWidget(
                ratesDistribution: ratesDistribution, avgRates: avgRates)
          ],
        ).marginBottom(4.h).withTitle(
            title: LocaleKeys.view_profile_rates_and_comments.tr(),
            titleHorizontalPadding: 0));
  }
}
