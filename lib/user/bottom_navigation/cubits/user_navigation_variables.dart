import 'package:flutter/cupertino.dart';

import '../user_nav_item.dart';

mixin UserNavigationVariables {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  final tabs = UserNavItem.values;
  final ValueNotifier<UserNavItem> currentTabNotifier = ValueNotifier(UserNavItem.home);
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
}
