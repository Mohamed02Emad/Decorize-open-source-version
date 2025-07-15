// import 'package:decorizer/common/common.dart';
// import 'package:decorizer/common/constant/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'constant/app_images.dart';
//
// class ImagesSlider extends StatelessWidget {
//   const ImagesSlider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       child: Container(
//         clipBehavior: Clip.antiAlias,
//         decoration: BoxDecoration(
//           color: context.appColors.onBackground,
//           // border: Border.all(
//           //   color: context.appColors.primary,
//           //   width: 1.5.h,
//           // ),
//           borderRadius: BorderRadius.circular(AppDimentions.mainCorner.h),
//         ),
//         child: ImageSlideshow(
//           /// Width of the [ImageSlideshow].
//           width: double.infinity,
//
//           /// Height of the [ImageSlideshow].
//           height: 200.h,
//
//           /// The page to show when first creating the [ImageSlideshow].
//           initialPage: 0,
//
//           /// The color to paint the indicator.
//           indicatorColor: context.appColors.primary,
//
//           /// The color to paint behind th indicator.
//           indicatorBackgroundColor: Colors.grey,
//
//           /// The widgets to display in the [ImageSlideshow].
//           /// Add the sample image file into the images folder
//           children: [
//             Image.asset(
//               AppImages.slider1,
//               fit: BoxFit.fill,
//             ),
//             Image.asset(
//               AppImages.slider2,
//               fit: BoxFit.fill,
//             ),
//             Image.asset(
//               AppImages.slider3,
//               fit: BoxFit.fill,
//             ),
//           ],
//
//           /// Called whenever the page in the center of the viewport changes.
//           onPageChanged: (value) {
//             print('Page changed: $value');
//           },
//
//           /// Auto scroll interval.
//           /// Do not auto scroll with null or 0.
//           autoPlayInterval: 3000,
//
//           /// Loops back to first slide.
//           isLoop: true,
//         ),
//       ),
//     );
//   }
// }
