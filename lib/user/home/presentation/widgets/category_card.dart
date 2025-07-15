import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final Function() onClick;

  const CategoryCard(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 36.h,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? context.appColors.primary
            : context.appColors.onBackground,
        borderRadius: BorderRadius.all(Radius.circular(12.h)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Row(
        children: [
          if (category.image?.url != null) ...{
            AppImage(
              path: category.image?.url ?? '',
              width: 22.w,
              height: 22.w,
              color:
                  isSelected ? context.appColors.white : context.appColors.text,
            ),
            6.gap,
          },
          Text(
            category.name.trans(),
            style: TextStyles.regular12(
                color: isSelected
                    ? context.appColors.white
                    : context.appColors.text),
          )
        ],
      ),
    ).clickable(onClick,
        radius: 12.h, color: !isSelected ? context.appColors.primary : null);
  }
}
