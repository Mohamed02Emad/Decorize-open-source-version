import 'package:decorizer/shared_features/chat/presentation/pages/chats_screen.dart';
import 'package:decorizer/shared_features/more/presentation/pages/more_screen.dart';
import 'package:decorizer/user/home/presentation/pages/user_home_screen.dart';
import 'package:decorizer/user/orders/presentation/screens/user_orders_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../common/constant/app_svgs.dart';
import '../../common/resources/gen/locale_keys.g.dart';

enum UserNavItem {
  home(
    title: LocaleKeys.bottomNavigation_home,
    selectedSvgPath: AppSvgs.homeSelected,
    unSelectedSvgPath: AppSvgs.homeUnSelected,
    screen: UserHomeScreen(),
  ),
  orders(
    title: LocaleKeys.bottomNavigation_orders,
    selectedSvgPath: AppSvgs.ordersSelected,
    unSelectedSvgPath: AppSvgs.ordersUnSelected,
    screen: UserOrdersScreen(),
  ),
  addButton(
    title: 'dummy',
    selectedSvgPath: AppSvgs.addSquare,
    unSelectedSvgPath: AppSvgs.addSquare,
    screen: UserHomeScreen(),
  ),
  messages(
    title: LocaleKeys.bottomNavigation_messages,
    selectedSvgPath: AppSvgs.messagesSelected,
    unSelectedSvgPath: AppSvgs.messagesUnSelected,
    screen: ChatsScreen(),
  ),
  more(
    title: LocaleKeys.bottomNavigation_more,
    selectedSvgPath: AppSvgs.moreSelected,
    unSelectedSvgPath: AppSvgs.moreUnSelected,
    screen: MoreScreen(),
  );

  final String title;
  final String selectedSvgPath;
  final String unSelectedSvgPath;
  final Widget screen;

  const UserNavItem({
    required this.title,
    required this.selectedSvgPath,
    required this.unSelectedSvgPath,
    required this.screen,
  });
}
