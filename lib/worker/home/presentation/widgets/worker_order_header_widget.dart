import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/util/get_file/pick_file_util.dart';
import '../../../../common/widget/app/app_image.dart';
import '../../../../common/widget/slider.dart';
import '../../domain/models/worker_order_details_model.dart';

class WorkerOrderHeaderWidget extends StatelessWidget {
  final WorkerOrderDetailsModel orderDetails;
   const WorkerOrderHeaderWidget({super.key, required this.orderDetails,});

  @override
  Widget build(BuildContext context) {
    final images = List.generate(orderDetails.files.length, (index) => orderDetails.files[index].url);

    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Height(12.h),
            Sliders(
              height: 176.h,
              viewportFraction: 1,
              children: images.map((image) => Hero(
                tag: 'order_header_image_$image',
                child: AppImage(
                  path: image,
                  fit: BoxFit.cover,
                  radius: 8.r,
                  height: 176.h,
                  width: double.infinity,
                ),
              ).withShadow(8.r).clickable(
                    () {
                  PickFileUtil.showFileSelected(
                    url: image,
                    heroTag: 'order_header_image_$image',
                  );
                },
                radius: 8.r,
              ).marginHorizontal(16.w)).toList(),
            ).fadeScaleAppear(),
            Height(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    orderDetails.content,
                    textAlign: TextAlign.start,
                    style: TextStyles.regular14(),
                  ).marginHorizontal(16.w),
                ),
              ],
            ).fadeScaleAppear(),
            Height(8.h),
          ],
        );
  }

}
