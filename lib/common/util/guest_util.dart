import 'package:decorizer/common/util/navigation_helper.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../common.dart';
import '../constant/textStyles.dart';
import '../di/injection_container.dart';

class GuestUtil {
  static bool get isGuest => sl<LoginInfoCubit>().isGuest;

  // static bool get isGuest => false;

  static executeOrAskToLogin(
      {required Function function, required BuildContext context}) {
    final bool isGuest = sl<LoginInfoCubit>().isGuest;
    return isGuest ? _showGuestBottomSheet(context) : function();
  }

  static void _showGuestBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        elevation: 20,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.h),
            ),
            height: 200.h,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    'loginToEnjoy'.tr(),
                    style: TextStyles.semiBold18(),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  AppButton(
                    text: 'login'.tr(),
                    onClick: () {
                      _navigateToLogin(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  static void _navigateToLogin(BuildContext context) {
    popToFirst(context);
    Nav.pushReplacement(LoginScreen(
      userType: context.currentUserType ?? UserType.user,
    ));
  }
}
