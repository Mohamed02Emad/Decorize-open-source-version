import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/paging/paginated_sliver_list_view.dart';
import 'package:decorizer/common/widget/paging/paging_up_button.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/chats/chats_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:decorizer/shared_features/chat/presentation/widgets/chat_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app_title_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatsCubit>()
        ..connectChatChannel(
            channelName:
                'private-updated.chat.list.${sl<LoginInfoCubit>().user?.id}'),
      child: const _ChatsScreenBody(),
    );
  }
}

class _ChatsScreenBody extends StatelessWidget {
  const _ChatsScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr(LocaleKeys.more_chats),
        hasBackButton: false,
      ),
      body: RefreshIndicator.adaptive(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          _refresh(context);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: context.read<ChatsCubit>().scrollController,
          slivers: <Widget>[
            PaginatedSliverListView(
              padding: EdgeInsets.only(
                bottom: 20,
              ).copyWith(bottom: 40.h),
              pagingController: context.read<ChatsCubit>().paginateController,
              onRetry: () => _refresh(context),
              itemBuilder: (context, item, index) => ChatCard(
                chatModel: item,
                onChatUpdated: (updatedChat) {
                  context.read<ChatsCubit>().upsertChat(updatedChat);
                },
              ),
              loadingItemBuilder: Skeleton(
                width: double.infinity,
                height: 76.h,
                radius: 0.r,
              ).marginBottom(8),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: context.read<ChatsCubit>().showUpButton,
        builder: (context, value, child) => PagingUpButton(
                showButton: value,
                onClick: context.read<ChatsCubit>().scrollToTop)
            .marginBottom(4.h),
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<ChatsCubit>().refresh();
    sl<UnreadMessageCountCubit>().getUnreadCount();
  }
}
