import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedListView<T> extends StatelessWidget {
  const PaginatedListView({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
    this.onRetry,
    this.padding,
    this.title,
    this.titleStyle,
    this.enableScroll = true,
    this.height = 120,
    this.separatorHeight = 16,
    this.separator,
    this.loadingItemBuilder,
    this.emptyItemBuilder,
    this.physics,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
  });

  final bool reverse;
  final ScrollPhysics? physics;
  final double height;
  final bool enableScroll;
  final double separatorHeight;
  final Widget Function(int)? separator;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingItemBuilder;
  final Widget Function(BuildContext context)? emptyItemBuilder;
  final PagingController<dynamic, T> pagingController;
  final void Function()? onRetry;
  final Axis scrollDirection;
  final ScrollController? scrollController;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: scrollDirection == Axis.horizontal ? height : null,
        child: PagedListView.separated(
          shrinkWrap: true,
          reverse: reverse,
          pagingController: pagingController,
          scrollController: scrollController,
          scrollDirection: scrollDirection,
          physics: physics ?? const BouncingScrollPhysics(),
          keyboardDismissBehavior: keyboardDismissBehavior,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: itemBuilder,
            noItemsFoundIndicatorBuilder: emptyItemBuilder ??
                (ctx) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.error_error_no_results.tr(),
                          style: TextStyles.semiBold18()),
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
                    ],
                  );
                },
            newPageProgressIndicatorBuilder: (context) =>
                const CupertinoActivityIndicator().center(),
            // firstPageErrorIndicatorBuilder: (context) => ErrorScreen(
            //   onRetry: onRetry ?? () => pagingController.refresh(),
            // ),
            firstPageProgressIndicatorBuilder: (context) {
              return loadingItemBuilder ??
                  const CupertinoActivityIndicator().center();
            },
          ),
          separatorBuilder: (_, index) => separator?.call(index) ??
              SizedBox(height: separatorHeight, width: separatorHeight),
        ).withTitle(
          title: title,
          titleStyle: titleStyle ??
              TextStyles.regular14(
                context: context,
              ),
        ));
  }
}
