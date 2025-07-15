import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/user/home/presentation/pages/all_designs_screen.dart';
import 'package:decorizer/user/home/presentation/widgets/skeletons/suggested_designs_skeleton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignsGrid extends StatelessWidget {
  const DesignsGrid({
    super.key,
    required this.designs,
    this.isLoading = false,
    required this.onDesignTap,
    this.category,
  });

  final List<String> designs;
  final bool isLoading;
  final Function(String design) onDesignTap;
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SuggestedDesignsSkeleton();
    }
    final int displayAmount = 5;
    final displayDesigns = designs.take(displayAmount).toList();
    final hasMore = designs.length > displayAmount;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1,
      ),
      itemCount: displayDesigns.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasMore && index == displayDesigns.length) {
          return SeeAllItem(
            onTap: () => _onSeeAllTap(context),
            count: displayAmount,
          ).fadeScaleAppear();
        }
        final design = displayDesigns[index];
        return DesignItem(
          design: design,
          onTap: () => onDesignTap(design),
        ).fadeScaleAppear();
      },
    );
  }

  void _onSeeAllTap(BuildContext context) {
    Nav.push(AllDesignsScreen(category: category));
  }
}

class DesignItem extends StatelessWidget {
  const DesignItem({
    super.key,
    required this.design,
    required this.onTap,
  });

  final String design;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'design_$design',
        child: AppImage(
          width: 120.h,
          height: 120.h,
          radius: 12.h,
          path: design,
        ),
      ),
    );
  }
}

class SeeAllItem extends StatelessWidget {
  const SeeAllItem({
    super.key,
    required this.onTap,
    required this.count,
  });

  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr(LocaleKeys.common_see_all),
              style: TextStyle(
                color: context.appColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.gap,
            Text(
              '($count+)',
              style: TextStyle(
                color: context.appColors.primary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
