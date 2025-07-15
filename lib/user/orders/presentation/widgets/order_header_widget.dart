import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/slider.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHeaderWidget extends StatelessWidget {
  final OrderDetailsModel orderDetails;

  const OrderHeaderWidget({
    super.key,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final currentIndexNotifier = ValueNotifier<int>(0);
    final images = List.generate(
        orderDetails.files.length, (index) => orderDetails.files[index].url);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Height(12.h),
        // Image slider
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
        // if (!orderState.isPending)
      ],
    );
  }
}