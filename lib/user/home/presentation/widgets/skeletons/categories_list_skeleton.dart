import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesListSkeleton extends StatelessWidget {
  const CategoriesListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Skeleton(
            height: 36.h,
            width: 38.w + index * 16.w,
            radius: 12.r,
          ).marginEnd(8.w);
        },
      ),
    );
  }
}
