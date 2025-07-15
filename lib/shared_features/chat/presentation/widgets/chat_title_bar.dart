import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/widget/app/app_image.dart';
import '../../../../common/widget/back_button.dart';

class ChatTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String image;
  final Function()? onBackPressed;

  const ChatTitleBar({super.key, required this.name, required this.image, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: context.appColors.onBackground,
        borderRadius: BorderRadius.only(bottomLeft: 14.radius, bottomRight: 14.radius),
        boxShadow: context.boxShadow,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ).copyWith(top:  MediaQuery.of(context).padding.top),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SizedBox(
                height: 40.w,
                width: 40.w,
                child: FittedBox(
                  child: AppBackButton(
                    color: context.appColors.text,
                    onPressOverride: onBackPressed,
                  ),
                ),
              ),
            AppImage(
              path: image,
              width: 34.w,
              height: 34.w,
              radius: 34.w,
            ),
            6.w.gap,
            Text(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.semiBold13(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((60.h) + MediaQuery.of(Nav.globalContext).padding.top);
}
