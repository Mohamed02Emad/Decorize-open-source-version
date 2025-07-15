import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';

class WidgetClipper extends CustomClipper<RRect> {
  final double left;
  final double top;
  final double right;
  final double bottom;

  WidgetClipper({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  WidgetClipper.directional({
    required double start,
    required double top,
    required double end,
    required double bottom,
  }) : this(
          left: Nav.globalContext.isArabic ? end : start,
          top: top,
          right: Nav.globalContext.isArabic ? start : end,
          bottom: bottom,
        );

  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndCorners(
      Rect.fromLTWH(
          left, top, size.width - left - right, size.height - top - bottom),
      topLeft: Radius.zero,
      topRight: Radius.zero,
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    );
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => false;
}
