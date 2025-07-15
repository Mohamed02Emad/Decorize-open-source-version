import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/worker/offers/presentation/screens/previous_offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app_title_bar.dart';
import '../../../../common/widget/paging/paging_up_button.dart';
import '../../../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../cubit/current_offers_cubit/current_offers_cubit.dart';
import '../cubit/previous_offers_cubit/previous_offers_cubit.dart';
import 'current_offers_screen.dart';

class WorkerOffersScreen extends StatefulWidget {
  const WorkerOffersScreen({super.key});

  @override
  State<WorkerOffersScreen> createState() => _WorkerOffersScreenState();
}

class _WorkerOffersScreenState extends State<WorkerOffersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController scrollController = ScrollController();

  ValueNotifier<bool> showUpButton = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => sl<GetCurrentOffersCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<LoginInfoCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<GetPreviousOffersCubit>(),
      ),
    ], child: _workerOffers());
  }

  Widget _workerOffers() {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr(LocaleKeys.order_details_offers_title),
      ),
      body: NestedScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.h,
              ),
            ),
            SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                elevation: 6.h,
                backgroundColor: context.appColors.background,
                flexibleSpace: Container(
                  margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w , ),
                  decoration: BoxDecoration(
                      color: context.appColors.background,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border(
                          bottom: BorderSide(
                        color: context.appColors.onBackground,
                        width: 1.w,
                      ))),
                  child: TabBar(
                      controller: _tabController,
                      labelColor: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                      unselectedLabelColor: context.appColors.grey,
                      indicatorColor: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          text:
                              context.tr(LocaleKeys.OrderScreen_current_orders),
                        ),
                        Tab(
                          text: context
                              .tr(LocaleKeys.OrderScreen_previous_orders),
                        ),
                      ]),
                )),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 6.h,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            const CurrentOffersScreen(),
            const PreviousOffersScreen(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: showUpButton,
        builder: (context, value, child) =>
            PagingUpButton(showButton: value, onClick: scrollToTop)
                .marginBottom(4.h),
      ),
    );
  }

  void _scrollListener() {
    double offset = scrollController.offset;
    final newShowButton = offset > 320;
    if (newShowButton != showUpButton.value) {
      showUpButton.value = newShowButton;
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
    );
  }
}
