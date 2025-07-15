import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/slider.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsSlider extends StatelessWidget {
  const AdsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeAdsUrls = [
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1631679706909-1844bbd07221?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    ];
    return Sliders(
      height: 140.h,
      enlargeFactor: 0.2,
      viewportFraction: 0.8,
      children: fakeAdsUrls
          .map((url) => AppImage(
                path: url,
                width: double.infinity,
                radius: 8.r,
              ))
          .toList(),
    ).withTitle(title: LocaleKeys.home_ads_space.tr());
  }
}
