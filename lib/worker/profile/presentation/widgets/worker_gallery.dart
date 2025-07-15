import 'dart:math';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/fake_data_generator.dart';
import 'package:decorizer/worker/profile/domain/models/gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerGallery extends StatelessWidget {
  List<GalleryModel> gallery;
  WorkerGallery({required this.gallery, super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingCard(
        padding: EdgeInsets.zero,
        child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 12.w, end: 12.w, top: 8.h, bottom: 8.h),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    'معرض الاعمال',
                    style: TextStyles.semiBold14(context: context),
                  ),
                  Spacer(),
                  Text(
                    'عرض الكل',
                    style: TextStyles.regular14Weight400(
                        color: context.appColors.primary, context: context),
                  )
                ],
              ),
              Height(12.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.w, // Horizontal spacing
                  mainAxisSpacing: 8.h, // Vertical spacing
                  childAspectRatio: 1.2, // Aspect ratio of each grid item
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  // final item = gallery[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: AppImage(
                      path: FakeDataGenerator.randomFakeImage,
                      // path: item.image,
                      fit: BoxFit.cover,
                    )
                  );
                },
              )
            ])));
  }
}
