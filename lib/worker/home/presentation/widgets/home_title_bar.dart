import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/common/widget/animations/slide.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/resources/gen/assets.gen.dart';
import '../../../../shared_features/auth/domain/enums/user_type.dart';
import '../../../../shared_features/notifications/presentation/pages/notifications_screen.dart';

class HomeTitleBar extends StatelessWidget {
  const HomeTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isGuest = GuestUtil.isGuest;
    return SlideWrapper(
      slideDirection: SlideDirection.down,
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16.w,
            right: 16.w,
            bottom: 8.h),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.only(bottomLeft: 14.radius, bottomRight: 14.radius),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              color: context.appColors.text.withValues(alpha: 0.18),
              spreadRadius: 0,
              blurRadius: 12,
            )
          ],
          color: context.appColors.onBackground,
        ),
        child: isGuest ? const _GuestBar() : const _UserBar(),
      ),
    );
  }
}

class _GuestBar extends StatelessWidget {
  const _GuestBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(LocaleKeys.home_welcome),
          style: TextStyles.semiBold14(),
        ),
        AppButton(
          text: context.tr(LocaleKeys.auth_login),
          height: 26.h,
          backgroundColor: context.appColors.onBackground,
          borderColor: context.appColors.primary,
          isBordered: true,
          textStyle: TextStyles.semiBold12(color: context.appColors.primary),
          onClick: () => _openLoginScreen(context),
        ),
      ],
    ).marginVertical(7.h);
  }

  void _openLoginScreen(BuildContext context) {
    Nav.pushReplacement(LoginScreen(
      userType: context.currentUserType ?? UserType.user,
    ));
  }
}

class _UserBar extends StatelessWidget {
  const _UserBar();

  @override
  Widget build(BuildContext context) {
    final User user = context.read<LoginInfoCubit>().user!;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        AppImage(
          path: user.image,
          width: 41.w,
          height: 41.w,
          radius: 41.w,
        ).clickable(() => _openProfile(context), radius: 41.w),
        8.gap,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr(LocaleKeys.home_welcome),
              style: TextStyles.semiBold14(),
            ),
            Text(
              user.name,
              style: TextStyles.bold12(),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.all(6.w),
          child: SvgPicture.asset(
            Assets.image.svg.notifications.path,
            width: 22.w,
            height: 22.w,
            colorFilter: context.isDarkMode
                ? context.appColors.white.colorFilter
                : context.appColors.primary.colorFilter,
          ),
        ).clickable(
          _openNotificationsScreen,
          radius: 22.w,
          color: context.isDarkMode
              ? context.appColors.white.withValues(alpha: 0.15)
              : context.appColors.primary.withValues(alpha: 0.15),
        ),
      ],
    ).marginTop(6.h);
  }

  void _openNotificationsScreen() {
    Nav.push(const NotificationsScreen());
  }

  void _openProfile(BuildContext context) {

  }
}
