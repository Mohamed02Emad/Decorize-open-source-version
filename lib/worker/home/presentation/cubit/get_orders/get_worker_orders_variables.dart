import 'package:decorizer/worker/home/domain/models/worker_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin GetWorkerOrdersCubitVariables {

  final ScrollController scrollController = ScrollController();
  ValueNotifier<bool> showUpButton = ValueNotifier(false);
  late final PagingController<int, WorkerOrderModel> paginateController;
  late final List<WorkerOrderModel> orders ;
}