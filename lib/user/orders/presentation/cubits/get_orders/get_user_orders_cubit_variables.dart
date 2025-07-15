import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin GetUserOrdersCubitVariables {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<OrderDetailsState?> statusNotifier =
      ValueNotifier(null);
        ValueNotifier<bool> showUpButton = ValueNotifier(false);
  final ScrollController scrollController = ScrollController();
  late final PagingController<int, OrderModel> paginateController;
  final Debouncer searchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));

  bool get hasFilter => statusNotifier.value != null;

}
