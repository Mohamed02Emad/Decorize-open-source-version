import 'package:decorizer/common/cli_common.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/animations/scale.dart';
import '../../../../common/widget/app/app_image.dart';
import '../../../../fake_data_generator.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
        margin:
            EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
        radius: 12.r,
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final image = FakeDataGenerator.randomFakeImage;
            final radius = 10.h;
            return ScaleWrapper(
                duration: 450.duration,
                startScale: 0,
                endScale: 1,
                startDelay: 80.milliseconds * index,
                child: AppImage(
                  width: double.infinity,
                  height: double.infinity,
                  radius: radius,
                  path: image,
                )
                    .clickable(() => _openDesign(context, image),
                        radius: radius)
                    .withShadow(radius));
          },
        ).marginVertical(4.h).withTitle(
              title: LocaleKeys.view_profile_portfolio.tr(),
              titleHorizontalPadding: 0,
              titleStyle: TextStyles.semiBold14(),
              onSeeAllClicked: () {
                _seeAllClicked(context);
              },
            ));
  }

  void _openDesign(BuildContext context, String image) {}

  void _seeAllClicked(BuildContext context) {}
}
