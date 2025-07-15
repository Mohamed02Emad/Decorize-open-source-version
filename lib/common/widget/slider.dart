import 'package:carousel_slider/carousel_slider.dart';
import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sliders extends StatelessWidget {
  final List<Widget> children;
  final double? height;
  final bool enlargeCenterPage;
  final bool autoScroll;
  final Duration? freezeDuration;
  final Duration? scrollDuration;
  final Curve scrollCurve;
  final double enlargeFactor;
  final double viewportFraction;
  Sliders({
    super.key,
    required this.children,
    this.height,
    this.enlargeCenterPage = true,
    this.autoScroll = true,
    this.freezeDuration,
    this.scrollDuration,
    this.scrollCurve = Curves.easeInOutCubic,
    this.enlargeFactor = .2,
    this.viewportFraction = .62,
  });

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height ?? 240.h,
            autoPlay: autoScroll,
            autoPlayInterval: freezeDuration ?? const Duration(seconds: 7),
            autoPlayAnimationDuration:
                scrollDuration ?? const Duration(milliseconds: 900),
            autoPlayCurve: scrollCurve,
            enlargeCenterPage: enlargeCenterPage,
            enlargeFactor: enlargeFactor,
            viewportFraction: viewportFraction,
            onPageChanged: (index, reason) {
              _currentPage.value = index;
            },
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          items: children,
        ),
        if (children.length > 1) ...{
          const SizedBox(height: 4),
           Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, currentIndex, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children.asMap().entries.map((entry) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.8),
                          width: 1,
                        ),
                        color: currentIndex == entry.key
                            ? Colors.white
                            : const Color.fromARGB(255, 214, 214, 214).withValues(alpha: 0.4),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        },
      ],
    );
  }
}
