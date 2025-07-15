import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/paging/paginated_sliver_list_view.dart';
import 'package:decorizer/common/widget/paging/paging_up_button.dart';
import 'package:decorizer/shared_features/orders/presentation/widgets/search%20bar/filter_search.dart';
import 'package:decorizer/shared_features/orders/presentation/widgets/search%20bar/order_screen_searchbar.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_orders/get_user_orders_cubit.dart';
import 'package:decorizer/user/orders/presentation/widgets/filter_orders_bottom_sheet.dart';
import 'package:decorizer/user/orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrdersScreen extends StatelessWidget {
  const UserOrdersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<GetUserOrdersCubit>()),
    ], child: _UserOrdersScreenBody());
  }
}

class _UserOrdersScreenBody extends StatelessWidget {
  const _UserOrdersScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.tr(LocaleKeys.OrderScreen_orders),
          textAlign: TextAlign.center,
          style: TextStyles.semiBold17(),
        ),
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator.adaptive(
        backgroundColor: context.isDarkMode ? context.appColors.onBackground : Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          _refresh(context);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: context.read<GetUserOrdersCubit>().scrollController,
          slivers: <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: context.appColors.background ,
              floating: true,
              elevation: 6.h,
              flexibleSpace: Container(
                height: 40.h,
                margin: EdgeInsetsDirectional.only(
                    start: 16.w, end: 16.w, top: 2.h),
                child: Row(
                  children: [
                    const OrderScreenSearchBar(),
                    SizedBox(
                      width: 8.w,
                    ),
                    ValueListenableBuilder(
                      valueListenable:
                          context.read<GetUserOrdersCubit>().statusNotifier,
                      builder: (context, value, child) => FilterSearchButton(
                          onTap: () {
                            _onFilterClicked(context);
                          },
                          hasFilter: value != null),
                    )
                  ],
                ),
              ),
            ),
            PaginatedSliverListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)
                  .copyWith(bottom: 40.h),
              pagingController:
                  context.read<GetUserOrdersCubit>().paginateController,
              onRetry: () => _refresh(context),
              itemBuilder: (context, item, index) => UserOrderCard(
                key: ValueKey(item.id),
                order: item,
                onDeleteOrder: (order) {
                  _removeOrderFromList(context, order);
                },
              ),
              loadingItemBuilder: Skeleton(
                width: double.infinity,
                height: 110.h,
                radius: 12.r,
              ).marginBottom(8),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: context.read<GetUserOrdersCubit>().showUpButton,
        builder: (context, value, child) => PagingUpButton(
                showButton: value,
                onClick: context.read<GetUserOrdersCubit>().scrollToTop)
            .marginBottom(4.h),
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<GetUserOrdersCubit>().refresh();
  }

  void _onFilterClicked(BuildContext context) {
    final cubit = context.read<GetUserOrdersCubit>();
    FilterOrdersBottomSheet.show(context,
        initialStatus: cubit.statusNotifier.value, onApply: (status) {
      cubit.statusNotifier.value = status;
      cubit.refresh();
    });
  }

  void _removeOrderFromList(BuildContext context, OrderModel order) {
    final cubit = context.read<GetUserOrdersCubit>();
    cubit.removeOrderFromList(order);
  }
}
