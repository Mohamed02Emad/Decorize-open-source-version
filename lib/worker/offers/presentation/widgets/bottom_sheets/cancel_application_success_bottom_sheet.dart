import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/util/navigation_helper.dart';
import '../../../../../common/widget/app/app_image.dart';

class CancelApplicationSuccessBottomSheet extends StatelessWidget {
  CancelApplicationSuccessBottomSheet._({this.onRefresh});
  void Function()? onRefresh;
  static void show({
    required BuildContext context,
    Function()? onRefresh,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return CancelApplicationSuccessBottomSheet._(
          onRefresh: onRefresh,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    child: AppImage(path: Assets.image.png.cancel.path),
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
                          context
                              .tr(LocaleKeys.bottomSheet_cancel_request_header),
                          style: TextStyles.semiBold16(),
                          textAlign: TextAlign.center,
                        ),
                        Height(12.h),
                        Text(
                          context.tr(
                              LocaleKeys.bottomSheet_request_canceled_message),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AppButton.medium(
                      text: context.tr(LocaleKeys.bottomSheet_back_home),
                      onClick: () => _goToHomePage(context)),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    onRefresh?.call();
    popToFirst(context);
  }
}
