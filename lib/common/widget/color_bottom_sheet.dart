import 'package:decorizer/common/data/simple_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav/bottom_sheet/modal_bottom_sheet.dart';


class ColorBottomSheet extends ModalBottomSheet<SimpleResult> {
  final double height;
  final Widget child;

  ColorBottomSheet({
    Color? textColor,
    this.height = 230,
    required this.child,
    super.context,
    super.key,
    super.backgroundColor = Colors.white,
    super.handleColor = Colors.white,
    super.barrierColor = const Color(0x80000000),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: double.infinity,
      child: child,
    );
  }
}
