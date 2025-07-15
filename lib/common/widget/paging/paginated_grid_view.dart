import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class PaginatedGridView<T> extends StatelessWidget {
  const PaginatedGridView({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
    this.onRetry,
    this.padding,
    this.loadingItemBuilder,
    this.emptyItemBuilder,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 16,
    this.childAspectRatio = 1,
  });

  final EdgeInsetsGeometry? padding;
  final int crossAxisCount;
  final double crossAxisSpacing, mainAxisSpacing, childAspectRatio;
  final Widget? loadingItemBuilder;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final void Function()? onRetry;
  final Widget Function(BuildContext)? emptyItemBuilder;
  final PagingController<dynamic, T> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: itemBuilder,
        noItemsFoundIndicatorBuilder: emptyItemBuilder,
        newPageProgressIndicatorBuilder:
            (context) => const Center(child: CupertinoActivityIndicator()),
        firstPageErrorIndicatorBuilder:
            (context) =>
                AppErrorWidget(errorMessage: context.tr(LocaleKeys.error_error_happened),onRefresh: onRetry ?? () => pagingController.refresh()),
        firstPageProgressIndicatorBuilder: (context) {
          return loadingItemBuilder ??
              const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
