import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/shared_features/chat/presentation/pages/chats_screen.dart';
import 'package:decorizer/worker/home/presentation/pages/worker_home_screen.dart';
import 'package:flutter/material.dart';

import '../../common/resources/gen/locale_keys.g.dart';
import '../../shared_features/more/presentation/pages/more_screen.dart';
import '../offers/presentation/screens/worker_offers_screen.dart';

enum WorkerNavItem {
  home(AppSvgs.homeSelected, LocaleKeys.bottomNavigation_home,
      WorkerHomeScreen(), AppSvgs.homeUnSelected),
  offers(AppSvgs.ordersSelected, LocaleKeys.bottomNavigation_offers,
      WorkerOffersScreen(), AppSvgs.ordersUnSelected),
  messages(
    AppSvgs.messagesSelected,
    LocaleKeys.bottomNavigation_messages,
    ChatsScreen(),
    AppSvgs.messagesUnSelected,
  ),
  more(AppSvgs.moreSelected, LocaleKeys.bottomNavigation_more, MoreScreen(),
      AppSvgs.moreUnSelected);

  final String activeIcon;
  final String inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const WorkerNavItem(
      this.activeIcon, this.tabName, this.firstPage, this.inActiveIcon);

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          isActivated ? activeIcon : inActiveIcon,
          key: ValueKey(tabName),
          colorFilter: ColorFilter.mode(
              isActivated
                  ? context.appColors.white
                  : context.appColors.white.withValues(alpha: 0.4),
              BlendMode.srcIn),
        ),
      ),
      label: context.tr(tabName),
    );
  }
}
