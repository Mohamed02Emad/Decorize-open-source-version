import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class CustomPaginatedGridView<T> extends StatelessWidget {
  const CustomPaginatedGridView({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
    this.onRetry,
    this.padding,
    this.loadingItemBuilder,
    this.emptyItemBuilder,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
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
    return SliverPadding(
      padding: padding ?? 16.w.edgeInsetsHorizontal,
      sliver: PagedSliverGrid(
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
              (context) => const CupertinoActivityIndicator().center(),
          firstPageErrorIndicatorBuilder:
              (context) => AppErrorWidget(
                errorMessage: context.tr(LocaleKeys.error_error_happened),
                onRefresh: onRetry ?? () => pagingController.refresh(),
              ),
          firstPageProgressIndicatorBuilder: (context) {
            return loadingItemBuilder ??
                const CupertinoActivityIndicator().center();
          },
        ),
      ),
    );
  }
}
