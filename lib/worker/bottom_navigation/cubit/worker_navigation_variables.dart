import 'package:decorizer/worker/bottom_navigation/worker_nav_item.dart';
import 'package:flutter/cupertino.dart';


mixin WorkerNavigationVariables {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  final tabs = WorkerNavItem.values;
  final ValueNotifier<WorkerNavItem> currentTabNotifier = ValueNotifier(WorkerNavItem.home);
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
}