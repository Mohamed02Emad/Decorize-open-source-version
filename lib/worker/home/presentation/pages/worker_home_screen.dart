import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/user/home/presentation/widgets/ads_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/skeleton.dart';
import '../../../../common/widget/paging/paginated_sliver_list_view.dart';
import '../../../../common/widget/paging/paging_up_button.dart';
import '../../../../user/home/presentation/widgets/home_title_bar.dart';
import '../cubit/get_orders/get_worker_orders_cubit.dart';
import '../widgets/ad_widget.dart';
import '../widgets/worker_home_order_card.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetWorkerOrdersCubit>(),
        ),
      ],
      child: _WorkerHomeScreenBody(),
    );
  }
}

class _WorkerHomeScreenBody extends StatelessWidget {
  const _WorkerHomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        edgeOffset: 110.h,
        onRefresh: () async {
         _refresh(context);
        },
        child: CustomScrollView(
          controller: context.read<GetWorkerOrdersCubit>().scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            PinnedHeaderSliver(
              child: const HomeTitleBar()
            ),
            // SliverToBoxAdapter(child: const AdWidget()),
            SliverToBoxAdapter(child: const AdsSlider()),
            PinnedHeaderSliver(
              child:Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                color: context.appColors.background,
                child: Text(context.tr(LocaleKeys.home_latest_listings),
                    style: TextStyles.bold14(context: context,)),
              ) ,
            ),
            SliverPadding(
              padding: 20.edgeInsetsBottom,
              sliver: PaginatedSliverListView(
                pagingController:
                    context.read<GetWorkerOrdersCubit>().paginateController,
                onRetry: () => _refresh(context),
                itemBuilder: (context, item, index) => WorkerHomeOrderCard(
                  order: item,
                  onRefresh: () => _refresh(context),
                ).fadeScaleAppear(startSize: 0.96,),
                loadingItemBuilder: Skeleton(
                  width: double.infinity,
                  height: 260.h,
                  radius: 12.r,
                ).fadeScaleAppear(startSize: 0.96,).marginBottom(8),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: context.read<GetWorkerOrdersCubit>().showUpButton,
        builder: (context, value, child) => PagingUpButton(
                showButton: value,
                onClick: context.read<GetWorkerOrdersCubit>().scrollToTop)
            .marginBottom(4.h),
      ),
    );
  }

  void _refresh(BuildContext context) {
     context.read<GetWorkerOrdersCubit>().refresh();
  }
}
