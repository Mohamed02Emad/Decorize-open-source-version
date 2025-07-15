import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/state_widgets/handle_ui_state.dart';
import 'package:flutter/material.dart';

class RequestState<T> extends Equatable {
  final RequestStateStatus status;
  final T? data;
  final String? message;

  bool get isLoading => status == RequestStateStatus.loading;

  bool get isInit => status == RequestStateStatus.init;

  bool get isSuccess => status == RequestStateStatus.success;

  bool get isError => status == RequestStateStatus.error;

  bool get isPagingLoading => status == RequestStateStatus.pagingLoading;

  const RequestState._({
    required this.status,
    required this.data,
    required this.message,
  });

  factory RequestState.initial() {
    return RequestState._(
      status: RequestStateStatus.init,
      data: null,
      message: null,
    );
  }

  factory RequestState.loading({bool pagingLoading = false}) {
    return RequestState._(
      status: pagingLoading
          ? RequestStateStatus.pagingLoading
          : RequestStateStatus.loading,
      data: null,
      message: null,
    );
  }

  factory RequestState.success(T? data, {String? message}) {
    return RequestState._(
      status:  RequestStateStatus.success,
      data: data,
      message: message,
    );
  }

  factory RequestState.error(String errorMessage , {T? data}) {
    return RequestState._(
      status:  RequestStateStatus.error,
      data: data,
      message: errorMessage,
    );
  }

  Widget build({
    required Widget Function(T data) successBuilder,
    Function()? onRetry,
    Widget? errorWidget,
    Widget? loadingWidget,
  }) {
    return HandleUiState(
      childBuilder: successBuilder,
      state: this,
      errorWidget: errorWidget,
      loadingWidget: loadingWidget,
      onRetry: onRetry,
    );
  }

    Widget buildSliver({
    Widget? onInit,
    Widget? onLoading,
    Widget? onFailed,
    Function()? onRetry,
    required Widget Function(T data) onSuccess,
    bool enableLoading = true,
  }) {
    switch (status) {
      case RequestStateStatus.init:
        return onInit ?? const SliverToBoxAdapter(child: SizedBox.shrink(),);
      case RequestStateStatus.loading:
        return enableLoading
            ? onLoading ?? const SliverToBoxAdapter(child: AppLoading(),)
            : onSuccess(data as T);
        case RequestStateStatus.success:
        case RequestStateStatus.pagingLoading:
        return onSuccess(data as T);
      case RequestStateStatus.error:
        return onFailed ?? SliverToBoxAdapter(child: AppErrorWidget(errorMessage: message ?? LocaleKeys.error_error_happened.tr(), onRefresh: onRetry),);

    }
  }


  void listen({
     Function(T data, String? message)? onSuccess,
    Function(String message)? onError,
    Function()? onLoading,
  }) {
    if (isSuccess) {
      onSuccess?.call(data as T, message);
    } else if (isError) {
      onError?.call(message ?? LocaleKeys.error_error_happened.tr());
    } else if (isLoading) {
      onLoading?.call();
    }
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, isError, isPagingLoading, data, message];
}

enum RequestStateStatus {
  init,
  loading,
  error,
  success,
  pagingLoading;
}
