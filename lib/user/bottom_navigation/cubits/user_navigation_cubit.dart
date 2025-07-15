import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/user/bottom_navigation/cubits/user_navigation_variables.dart';
import 'package:decorizer/user/bottom_navigation/user_nav_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';

part 'user_navigation_state.dart';

@Singleton()
class UserNavigationCubit extends BaseCubit<UserNavigationState>
    with UserNavigationVariables {
  UserNavigationCubit() : super(UserNavigationState.initial()) {
    _initNavigatorKeys();
  }

  UserNavItem get currentTab => currentTabNotifier.value;

  int get currentIndex => currentIndexNotifier.value;

  setCurrentTab(UserNavItem tab) {
    currentTabNotifier.value = tab;
    currentIndexNotifier.value = tabs.indexOf(tab);
  }

  setCurrentIndex(int index) {
    currentTabNotifier.value = tabs[index];
    currentIndexNotifier.value = index;
  }

  GlobalKey<NavigatorState> get currentTabNavigationKey =>
      navigatorKeys[currentIndex];

  bool get isRootPage =>
      currentTab == UserNavItem.home &&
      currentTabNavigationKey.currentState?.canPop() == false;

  void _initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

  IndexedStack get pages => IndexedStack(
        index: currentIndex,
        children: tabs
            .asMap()
            .entries
            .map((entry) => Offstage(
                  offstage: currentTab != entry.value,
                  child: entry.value.screen,
                ))
            .toList(),
      );
}
