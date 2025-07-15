import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/worker/bottom_navigation/cubit/worker_navigation_variables.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../worker_nav_item.dart';

part 'worker_navigation_state.dart';

@Singleton()
class WorkerNavigationCubit extends BaseCubit<WorkerNavigationState>
    with WorkerNavigationVariables {
  WorkerNavigationCubit() : super(WorkerNavigationState.initial()) {
    _initNavigatorKeys();
  }

  WorkerNavItem get currentTab => currentTabNotifier.value;

  int get currentIndex => currentIndexNotifier.value;

  setCurrentTab(WorkerNavItem tab) {
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
      currentTab == WorkerNavItem.home &&
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
      child: entry.value.firstPage,
    ))
        .toList(),
  );
}
