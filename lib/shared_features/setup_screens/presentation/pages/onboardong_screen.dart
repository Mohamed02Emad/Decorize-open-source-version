import 'package:decorizer/common/common.dart' as common;
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/shared_features/setup_screens/presentation/pages/user_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nav/nav.dart';

import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/assets.gen.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/util/system_bars_util.dart';
import '../../../../common/widget/spaces.dart';
import '../../../auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../widgets/onboarding.dart';
import '../widgets/onboarding_body.dart';
import '../widgets/onboarding_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() {
      SystemBarsUtil.changeStatusBarColor(Colors.transparent,
          isBlackIcons: true);
    });
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
            ),
            SvgPicture.asset(
              AppSvgs.onboardingBg,
              width: context.deviceWidth,
            ).scale(scaleValue: 1.2),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              bottom: 0,
              child: Onboarding(
                onboardings: [
                  OnBoardingBody(
                    svgAsset: Assets.image.svg.onboarding1.path,
                    text: LocaleKeys.setup_onboarding1.tr(),
                    subTitle: LocaleKeys.setup_onboarding1_message.tr(),
                  ),
                  OnBoardingBody(
                    svgAsset: Assets.image.svg.onboarding2.path,
                    text: LocaleKeys.setup_onboarding2.tr(),
                    subTitle: LocaleKeys.setup_onboarding2_message.tr(),
                  ),
                  OnBoardingBody(
                    svgAsset: Assets.image.svg.onboarding3.path,
                    text: LocaleKeys.setup_onboarding3.tr(),
                    subTitle: LocaleKeys.setup_onboarding3_message.tr(),
                  ),
                ],
                onPageChanged: (context, currentPage) {
                  _currentPageNotifier.value = currentPage;
                },
                buildFooter: (context, currentPage, setIndex) {
                  return _buildNextButton(currentPage, setIndex);
                },
                buildHeader: (context, currentPage, setIndex) {
                  return _buildSkipAndPreviousBar(currentPage, setIndex);
                },
              ),
            ),
            Positioned(
              bottom: 120.h,
              left: 0,
              right: 0,
              child: ValueListenableBuilder(
                valueListenable: _currentPageNotifier,
                builder: (context, currentPage, child) =>
                    OnboardingPageIndicator(
                  currentPage: currentPage,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void finishOnBoarding() {
    sl<LoginInfoCubit>().finishOnBoarding();
    // Nav.pushReplacement(const LoginScreen());
    Nav.pushReplacement(const UserTypeScreen());
  }

  void nextPage(int currentIndex) {
    _currentPageNotifier.value = currentIndex + 1;
  }

  void previousPage(int currentIndex) {
    _currentPageNotifier.value = currentIndex - 1;
  }

  Widget _buildSkipAndPreviousBar(
    int currentIndex,
    Function(int index) setIndex,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Width(16.w),
          Text(
            LocaleKeys.action_skip.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ).marginAll(10).clickable(() {
            finishOnBoarding();
          }),
          const Spacer(),
          if (currentIndex > 0)
            Text(
              LocaleKeys.action_previous.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ).marginAll(10).clickable(() {
              setIndex(currentIndex - 1);
              previousPage(currentIndex);
            }),
          Width(16.w),
        ],
      ),
    );
  }

  Widget _buildNextButton(int currentIndex, Function(int index) setIndex) {
    return Container(
      color: context.appColors.background,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h, top: 2.h),
      child: AppButton(
        text: currentIndex == 2
            ? LocaleKeys.action_get_started.tr()
            : '  ${LocaleKeys.action_next.tr()}  ',
        onClick: () {
          if (currentIndex == 2) {
            finishOnBoarding();
          } else {
            setIndex(currentIndex + 1);
            nextPage(currentIndex);
          }
        },
        textStyle: TextStyles.bold16(color: context.appColors.white),
      ),
    );
  }
}
