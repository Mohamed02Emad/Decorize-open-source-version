import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/widget/animations/slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/animations/fade.dart';
import '../widget/animations/scale.dart';
import '../widget/app/widget_ripple.dart';

extension WidgetExtention on Widget {
  Widget clipTop(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  Widget center(
      {double? heightFactor, double? widthFactor, bool enabled = true}) {
    return enabled
        ? Center(
            heightFactor: heightFactor, widthFactor: widthFactor, child: this)
        : this;
  }

  SizedBox withHeight(double height) => SizedBox(height: height, child: this);
  Widget margin(EdgeInsetsGeometry margin) {
    return Padding(
      padding: margin,
      child: this,
    );
  }

  Widget marginBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  Widget marginTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget marginLeft(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  Widget marginRight(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  Widget marginStart(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: value),
      child: this,
    );
  }

  Widget marginEnd(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: value),
      child: this,
    );
  }

  Widget marginHorizontal(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget marginVertical(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: value),
      child: this,
    );
  }

  Widget marginAll(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.all(value),
      child: this,
    );
  }

  Widget clip(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  Widget withShadow(double radius) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: Nav.globalContext.boxShadow,
          borderRadius: radius.borderRadius),
      child: this,
    );
  }

  Widget background(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  Widget clickable(Function()? onClick, {double? radius, Color? color}) {
    if (onClick == null) return this;
    return WidgetRipple(
      onClick: onClick,
      radius: radius,
      rippleColor: color,
      child: this,
    );
  }

  Widget disableClicks(bool disable) {
    return IgnorePointer(
      ignoring: disable,
      child: this,
    );
  }

  Widget withBottomDivider() {
    final context = Nav.globalContext;
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.appColors.divider)),
      ),
      child: this,
    );
  }

  Widget withTitle({
    required String? title,
    TextStyle? titleStyle,
    double? titleHorizontalPadding,
    bool centerTitle = false,
    Function()? onSeeAllClicked,
  }) {
    if (title == null) return this;
    final context = Nav.globalContext;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (centerTitle) const Spacer(),
            Text(
              context.tr(title),
              style: titleStyle ?? TextStyles.bold14(),
              textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            ).marginHorizontal(titleHorizontalPadding ?? 16.w),
            const Spacer(),
            if (onSeeAllClicked != null)
              Text(
                context.tr(LocaleKeys.common_see_all),
                style: TextStyles.regular12(color: context.appColors.primary),
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              )
                  .marginVertical(4.h)
                  .marginHorizontal(2)
                  .clickable(
                    onSeeAllClicked,
                    radius: 8.h,
                    color: AppColors.primary.withOpacity(0.12),
                  )
                  .marginHorizontal(titleHorizontalPadding ?? 14.w),
          ],
        ),
        8.gap,
        this,
      ],
    );
  }

  Widget scale({double scaleValue = 1.0}) {
    return Transform.scale(
      scale: scaleValue,
      child: this,
    );
  }

  Widget fadeAppear() {
    return FadeAppearWrapper(child: this);
  }

  Widget scaleAppear() {
    return ScaleWrapper(child: this);
  }

  Widget fadeScaleAppear({
    double? startSize,
    double? endSize,
    double? startOpacity,
    double? endOpacity,
  }) {
    return ScaleWrapper(
      startScale: startSize ?? 0.9,
      endScale: endSize ?? 1,
      child: FadeAppearWrapper(
        beginOpacity: startOpacity ?? 0,
        endOpacity: endOpacity ?? 1,
        child: this,
      ),
    );
  }

  Widget fittedBox({
    BoxFit fit = BoxFit.contain,
  }) {
    return FittedBox(
      fit: fit,
      child: this,
    );
  }

  Widget slide({
    SlideDirection? slideDirection,
    Duration? duration,
    Duration? startAnimationDelay,
    Curve? curve,
    double? initialOffset,
  }) {
    return SlideWrapper(
      duration: duration,
      curve: curve,
      initialOffset: initialOffset,
      startAnimationDelay: startAnimationDelay,
      slideDirection: slideDirection ?? SlideDirection.end,
      child: this,
    );
  }
}
