import 'package:decorizer/common/extentions/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/widget/paging/paging_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/remote/request_state.dart';
import 'app_error_widget.dart';
import 'app_loading.dart';

class HandleUiState<T> extends StatelessWidget {
  final Widget Function(T) childBuilder;
  final Function()? onRetry;
  final Widget? errorWidget, loadingWidget;
  final RequestState state;

  const HandleUiState(
      {super.key,
      required this.childBuilder,
      required this.state,
      this.errorWidget,
      this.onRetry,
      this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    if (state.status == RequestStateStatus.init || state.isLoading) {
      return loadingWidget ?? AppLoading();
    }

    if (state.isError) {
      return errorWidget ??
          AppErrorWidget(
            errorMessage: state.message ?? 'error'.tr(),
            onRefresh: onRetry,
          ).marginHorizontal(16.w);
    }

    return state.isPagingLoading
        ? PagingLoading(
            isPaging: state.isPagingLoading,
            child: childBuilder(state.data as T),
          )
        : childBuilder(state.data as T);
  }
}
