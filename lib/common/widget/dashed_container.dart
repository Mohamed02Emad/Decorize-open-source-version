import 'package:dotted_border/dotted_border.dart';
import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dynamic_container.dart';

class DashedContainer extends StatelessWidget {
  final Function? onClick;
  final Widget child;
  final int horizontalMargin;
  final Color? color;

  DashedContainer({
    super.key,
    this.onClick,
    required this.child,
    this.horizontalMargin = 0,
    this.color,
  });

  final BorderRadius radius = BorderRadius.circular(8.h);
  final EdgeInsets innerPadding =
      EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h);

  @override
  Widget build(BuildContext context) {
    return DynamicContainer(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin.h),
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const <double>[9, 5],
        radius: Radius.circular(10.r),
        strokeWidth: 0.5,
        color: color ?? context.appColors.primary,
        child: ClipRRect(
          borderRadius: radius,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: radius,
            color: Colors.transparent,
            child: InkWell(
              splashColor:
                  (color ?? context.appColors.primary).withOpacity(0.4),
              focusColor: (color ?? context.appColors.primary).withOpacity(0.5),
              onTap: onClick == null
                  ? null
                  : () {
                      onClick!();
                    },
              child: Ink(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: innerPadding,
                      child: Center(
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
