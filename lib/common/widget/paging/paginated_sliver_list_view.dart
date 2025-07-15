import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedSliverListView<T> extends StatelessWidget {
  const PaginatedSliverListView({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
    this.onRetry,
    this.padding,
    this.title,
    this.titleStyle,
    this.enableScroll = true,
    this.height = 120,
    this.separatorHeight = 8,
    this.loadingItemBuilder,
    this.emptyItemBuilder,
    this.scrollDirection = Axis.vertical,
  });

  final double height;
  final bool enableScroll;
  final double separatorHeight;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingItemBuilder;
  final Widget Function(BuildContext)? emptyItemBuilder;
  final PagingController<dynamic, T> pagingController;
  final void Function()? onRetry;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      sliver: PagedSliverList.separated(
        pagingController: pagingController,
        separatorBuilder: (_, __) =>
            SizedBox(height: separatorHeight, width: separatorHeight),
        builderDelegate: PagedChildBuilderDelegate<T>(
          itemBuilder: itemBuilder,
          firstPageErrorIndicatorBuilder: (context) => AppErrorWidget(
              errorMessage: pagingController.error?.toString() ??
                  context.tr(LocaleKeys.error_error_happened),
              onRefresh: onRetry ?? () => pagingController.refresh()),
          newPageErrorIndicatorBuilder: (context) => AppErrorWidget(
              errorMessage: pagingController.error?.toString() ??
                  context.tr(LocaleKeys.error_error_no_results),
              onRefresh: onRetry ?? () => pagingController.refresh()),
          noItemsFoundIndicatorBuilder: emptyItemBuilder ??
              (ctx) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        pagingController.error?.toString() ??
                            LocaleKeys.error_error_no_results.tr(),
                        style: TextStyles.semiBold14(context: context)),
                    12.gap,
                    if (onRetry != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: AppButton(
                                  onClick: onRetry!,
                                  text: LocaleKeys.action_refresh.tr())),
                        ],
                      ),
                    50.gap,
                  ],
                );
              },
          newPageProgressIndicatorBuilder: (context) =>
              const CupertinoActivityIndicator().center(),
          // firstPageErrorIndicatorBuilder: (context) =>
          //     ErrorScreen(onRetry: onRetry ?? () => pagingController.refresh()),
          firstPageProgressIndicatorBuilder: (context) {
            return loadingItemBuilder != null
                ? Column(
                    children: [
                      loadingItemBuilder!,
                      loadingItemBuilder!,
                      loadingItemBuilder!,
                      loadingItemBuilder!,
                    ],
                  )
                : const CupertinoActivityIndicator().center();
          },
        ),
      ),
    );
  }
}
