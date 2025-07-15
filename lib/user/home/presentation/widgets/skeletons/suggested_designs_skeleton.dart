import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/fake_data_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedDesignsSkeleton extends StatelessWidget {
  const SuggestedDesignsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
            shrinkWrap: true,
            padding: 16.edgeInsetsHorizontal,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final image = FakeDataGenerator.randomFakeImage;
              return Skeleton(
                width: 120.h,
                height: 120.h,
                radius: 12.h,
                );
              },
            );
  }
}
