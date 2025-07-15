import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/util/clippers/widget_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: context.appColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            ),
            if (false)
              PositionedDirectional(
                top: -200,
                start: -140,
                child: ClipRRect(
                  clipper: WidgetClipper.directional(
                      start: 140, top: 200, end: 0, bottom: 0),
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      height: 340,
                      width: 340,
                      decoration: BoxDecoration(
                        color: context.appColors.primary.withOpacity(0.2),
                        borderRadius: 340.borderRadius,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: -50,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/portrait-young-smiling-delivery-man-wearing-red-cap_171337-17212.jpg"), // Replace with actual image
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 55.h),
        Text(
          "أحمد مجد",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "4.9",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(width: 4),
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 8),
            Text(
              "نجار",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
