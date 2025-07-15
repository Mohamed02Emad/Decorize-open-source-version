import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/datetime_extension.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/animations/scale.dart';
import 'package:decorizer/common/widget/animations/slide.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/widget/app/app_image.dart';
import '../pages/chat_details_screen.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;
  final Function(ChatModel)? onChatUpdated;
  const ChatCard({super.key, required this.chatModel, this.onChatUpdated});

  @override
  Widget build(BuildContext context) {
    final cachedId = context.read<LoginInfoCubit>().user?.id;
    final otherUser = chatModel.userOne.id == cachedId
        ? chatModel.userTwo
        : chatModel.userOne;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ScaleWrapper(
          child: AppImage(
            path: otherUser.image ?? 'error',
            width: 40.w,
            height: 40.w,
            radius: 40.w,
          ),
        ),
        6.w.gap,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SlideWrapper(
                    child: Text(
                      otherUser.name,
                      style: TextStyles.semiBold13(),
                    ),
                  ),
                  const Spacer(),
                  SlideWrapper(
                    slideDirection: SlideDirection.start,
                    child: Text(
                      chatModel.lastMessage?.createdAt?.dateDdMmYyyy ?? '',
                      style: TextStyles.regular11(
                        color: context.appColors.hintText,
                      ).copyWith(fontSize: 9.6.sp),
                    ),
                  ),
                  if (chatModel.unreadMessagesCount > 0) ...{
                    Container(
                      width: 20.w,
                      height: 20.w,
                      margin: EdgeInsetsDirectional.only(start: 6.w),
                      decoration: BoxDecoration(
                        color: context.appColors.red,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          chatModel.unreadMessagesCount.toString(),
                          style: TextStyles.regular11(
                              color: context.appColors.white),
                        ),
                      ),
                    ).fadeScaleAppear()
                  },
                ],
              ),
              SlideWrapper(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        chatModel.lastMessage?.message ?? '',
                        style: TextStyles.regular12(
                          color: context.appColors.hintText,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ).marginHorizontal(16.w).marginVertical(10.h).clickable(() {
      _openChat();
    }, radius: 0);
  }

  void _openChat() {
    Nav.push(ChatDetailsScreen(
      chatModel: chatModel,
    )).then((result){
      if(result != null && result is ChatModel){
        onChatUpdated?.call(result);
      }
    });
  }
}
