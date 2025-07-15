import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/navigation_helper.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/widget/app/app_image.dart';

class ApplicationSuccessBottomSheet extends StatelessWidget {
  ApplicationSuccessBottomSheet._({super.key});

  static void show({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ApplicationSuccessBottomSheet._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 20.h,
          bottom: 20.h,
        ),
        child: Wrap(
          children: [
            Center(
              child: Column(
                children: [
                  Center(
                    child: AppImage(
                      path: Assets.image.png.success.path,
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      start: 25.w,
                      end: 25.w,
                      top: 16.h,
                      bottom: 16.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          context.tr(LocaleKeys.bottomSheet_request_submitted_header),
                          style: TextStyles.semiBold16(),
                          textAlign: TextAlign.center,
                        ),
                        Height(12.h),
                        Text(
                          context.tr(LocaleKeys.bottomSheet_request_submitted_message),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    text: context.tr(LocaleKeys.bottomSheet_back_home),
                    onClick: () {
                      popToFirst(context);
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
