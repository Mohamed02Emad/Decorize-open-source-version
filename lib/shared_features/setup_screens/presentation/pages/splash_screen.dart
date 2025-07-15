import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_animations.dart';
import 'package:decorizer/common/constant/app_images.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/widget/animations/fade.dart';
import 'package:decorizer/common/widget/animations/scale.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/setup_screens/presentation/pages/user_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../user/bottom_navigation/widgets/user_navigation_container.dart';
import '../../../../worker/bottom_navigation/widgets/worker_navigation_container.dart';
import 'onboardong_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      _handleSplashDirections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primary,
      body: Stack(
        children: [
          Positioned(
            top: 128.h,
            right: -59.w,
            left: -61.w,
            bottom: 190.h,
            child: Opacity(
              opacity: 0.1,
              child: ScaleWrapper(
                duration: const Duration(milliseconds: 1800),
                startScale: 0.5,
                endScale: 0.8,
                child: FadeAppearWrapper(
                  duration: const Duration(milliseconds: 600),
                  beginOpacity: 0.7,
                  endOpacity: 1,
                  child: SvgPicture.asset(
                    Assets.image.svg.logoWhite.path,
                    height: 494.h,
                    width: 495.w,
                    colorFilter: context.appColors.white.colorFilter,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 128.h,
          //   right: -59.w,
          //   left: -61.w,
          //   bottom: 190.h,
          //   child: Opacity(
          //     opacity: 0.1,
          //     child: Lottie.asset(
          //       AppAnimations.splashAnimation,
          //       height: 494.h,
          //       width: 495.w,
          //       repeat: true,
          //       animate: true,
          //       fit: BoxFit.contain,
          //       alignment: Alignment.center,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 332.h,
          //   left: 145.5.w,
          //   right: 145.5.w,
          //   child: Image.asset(
          //     height: 84.h,
          //     width: 84.w,
          //     AppImages.whiteAppLogo,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          // Positioned(
          //   top: 430.h,
          //   left: 97.5.w,
          //   right: 97.5.w,
          //   bottom: 332.h,
          //   child: Text(
          //     'Decorizer',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 32.sp,
          //       fontFamily: 'IBM',
          //       color: Colors.white,
          //     ),
          //     textAlign: TextAlign.center,
          //   ).fadeScaleAppear(),
          // )
        ],
      ),
    );
  }

  void _handleSplashDirections() {
    final loginInfoCubit = sl<LoginInfoCubit>();
    final isOnboardingDone = loginInfoCubit.finishedOnBoarding;
    final isLoggedIn = loginInfoCubit.hasUser;

    if (!isOnboardingDone) {
      Nav.pushReplacement(const OnBoardingScreen());
      return;
    }

    if (isLoggedIn) {
      final userType = context.currentUserType!;
      final destination = userType.isClient
          ? const UserNavigationContainer()
          : const WorkerNavigationContainer();
      Nav.pushReplacement(destination);
    } else {
      Nav.pushReplacement(const UserTypeScreen());
    }
  }
}
