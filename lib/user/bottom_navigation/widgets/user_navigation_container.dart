import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/common/util/navigation_helper.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/login_screen.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:decorizer/shared_features/logout_stream.dart';
import 'package:decorizer/user/bottom_navigation/user_nav_item.dart';
import 'package:decorizer/user/bottom_navigation/widgets/user_custom_bottom_nav.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_orders/get_user_orders_cubit.dart';
import 'package:flutter/material.dart';

import '../../../common/di/injection_container.dart';
import '../../../common/util/system_bars_util.dart';
import '../../create_ad/presentation/pages/create_ad_screen.dart';
import '../cubits/user_navigation_cubit.dart';

class UserNavigationContainer extends StatefulWidget {
  const UserNavigationContainer({super.key});

  @override
  State<UserNavigationContainer> createState() =>
      UserNavigationContainerState();
}

class UserNavigationContainerState extends State<UserNavigationContainer>
    with SingleTickerProviderStateMixin {
  bool get extendBody => true;

  @override
  void initState() {
    super.initState();
    _initLogoutListener();
    _initCounters();
    final navigationCubit = sl<UserNavigationCubit>();
    navigationCubit.setCurrentIndex(0);
    sl<GetUserOrdersCubit>().startPagination();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setSystemBarColors(0);
    });
  }

  void _initCounters() {
    if (GuestUtil.isGuest) return;
    sl<UnreadMessageCountCubit>().getUnreadCount();
    sl<UnreadMessageCountCubit>().getUnreadCount();
  }

  void _initLogoutListener() {
    try {
      logoutStream.addListener((data) {
        _onUnauthorizedListener(data);
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  @override
  void dispose() {
    logoutStream.removeAllListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationCubit = sl<UserNavigationCubit>();
    return PopScope(
      canPop: navigationCubit.isRootPage,
      onPopInvoked: _handleBackPressed,
      child: UserCustomBottomNav(
        items: navigationCubit.tabs,
        onPageChanged: _changeTab,
        selectedIconColor: context.isDarkMode
            ? context.appColors.text
            : context.appColors.primary,
        unSelectedIconColor: context.appColors.grey,
      ),
    );
  }

  void _handleBackPressed(bool didPop) {
    final navigationCubit = sl<UserNavigationCubit>();
    if (!didPop) {
      if (navigationCubit.currentTabNavigationKey.currentState?.canPop() ==
          true) {
        Nav.pop(navigationCubit.currentTabNavigationKey.currentContext!);
        return;
      }

      if (navigationCubit.currentTab != UserNavItem.home) {
        _changeTab(navigationCubit.tabs.indexOf(UserNavItem.home));
      }
    }
  }

  bool _changeTab(int index) {
    final isGuest = GuestUtil.isGuest;
    if (index == 2) {
      _createDesignClicked(context);
      return false;
    }
    _setSystemBarColors(index);
    return true;
  }

  void _setSystemBarColors(int index) {
    SystemBarsUtil.changeStatusAndNavigationBars(
      statusBarColor: context.appColors.transparent,
      navBarColor: context.appColors.onPrimary,
      isBlackIcons: context.isDarkMode ? false : true,
    );
  }

  void _createDesignClicked(BuildContext context) async {
    GuestUtil.executeOrAskToLogin(
      function: () async {
        Nav.push(const CreateAdScreen());
      },
      context: context,
    );
  }

  void _onUnauthorizedListener(String data) async {
    showErrorToast(data);
    popToFirst(context);
    Nav.pushReplacement(LoginScreen(userType: UserType.user));
    sl<LoginInfoCubit>().clearCachedData();
  }
}
