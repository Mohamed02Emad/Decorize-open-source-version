import 'dart:io';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/dialogs/color_wheel_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentColorWidget extends StatelessWidget {
  final String title;
  final List<int> color;
  final Function(List<int>) onColorSelected;
  const SegmentColorWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.onColorSelected,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 3, child: Text(title + " :", style: TextStyles.semiBold12())),
        Expanded(
          flex: 11,
          child: Container(
                   height: 30.h,
                   decoration: BoxDecoration(
                     color:
                         Color.fromARGB(255, color[0], color[1], color[2]),
                     borderRadius: 8.borderRadius,
                     border: Border.all(color: context.appColors.grey_2),
                   ),
                 ).clickable(() => _openColorWheel(context)),
        ),
      ],
    ).marginHorizontal(16.w);
  }

  void _openColorWheel(
      BuildContext context) {
    ColorWheelDialog.show(
      context,
      (color) {
        onColorSelected(color);
      },
    );
  }
}
