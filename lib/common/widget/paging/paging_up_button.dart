import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagingUpButton extends StatelessWidget {
  final bool showButton;
  final Function() onClick;
  const PagingUpButton(
      {super.key, required this.showButton, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return showButton
        ? Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: context.appColors.primary,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 26.w,
              ),
            ).clickable(onClick, radius: 40.r),
          ).fadeAppear().marginBottom(8.h).marginStart(8.h)
        : Container();
  }
}
