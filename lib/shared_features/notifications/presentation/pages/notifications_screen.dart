import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/paging/paginated_sliver_list_view.dart';
import 'package:decorizer/common/widget/paging/paging_up_button.dart';
import 'package:decorizer/shared_features/notifications/presentation/cubits/mark_as_read/mark_as_read_cubit.dart';
import 'package:decorizer/shared_features/notifications/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:decorizer/shared_features/notifications/presentation/cubits/unread_notifications_count/unread_notifications_count_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/animations/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/app_title_bar.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<NotificationsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<MarkAsReadCubit>(),
        ),
      ],
      child: _NotificationsScreenBody(),
    );
  }
}

class _NotificationsScreenBody extends StatelessWidget {
  _NotificationsScreenBody();

  bool didReadNotifications = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr(LocaleKeys.notifications_title),
        hasBackButton: true,
      ),
      body: RefreshIndicator.adaptive(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          _refresh(context);
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<NotificationsCubit, NotificationsState>(
                listener: (context, state) {
              if (state.notificationsState.isSuccess && !didReadNotifications) {
                didReadNotifications = true;
                context.read<MarkAsReadCubit>().markAsRead();
              }
            }),
            BlocListener<MarkAsReadCubit, MarkAsReadState>(
              listener: (context, state) {
                if (state.markAsReadState.isSuccess) {
                  sl<UnreadNotificationsCountCubit>().getUnreadCount();
                }
              },
            ),
          ],
          child: CustomScrollView(
            controller: context.read<NotificationsCubit>().scrollController,
            slivers: <Widget>[
              PaginatedSliverListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)
                    .copyWith(bottom: 40.h),
                pagingController:
                    context.read<NotificationsCubit>().paginateController,
                onRetry: () => _refresh(context),
                itemBuilder: (context, item, index) => ScaleWrapper(
                    startScale: 0.96,
                    child: NotificationCard(notification: item)),
                loadingItemBuilder: Skeleton(
                  width: double.infinity,
                  height: 74.h,
                  radius: 12.r,
                ).marginBottom(8),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: context.read<NotificationsCubit>().showUpButton,
        builder: (context, value, child) => PagingUpButton(
                showButton: value,
                onClick: context.read<NotificationsCubit>().scrollToTop)
            .marginBottom(4.h),
      ),
    );
  }

  void _refresh(BuildContext context) {
    didReadNotifications = false;
    context.read<NotificationsCubit>().refresh();
  }
}
