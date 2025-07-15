import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatSendMessageSection extends StatefulWidget {
  final Function(String) onSendButtonPressed;

  const ChatSendMessageSection({super.key, required this.onSendButtonPressed});

  @override
  State<ChatSendMessageSection> createState() => _ChatSendMessageSectionState();
}

class _ChatSendMessageSectionState extends State<ChatSendMessageSection> {
  final TextEditingController controller = TextEditingController();
  bool isSendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    isSendButtonEnabled = controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w),
              child: AppTextField(
                controller: controller,
                hint: context.tr(LocaleKeys.chat_enter_message),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed:  _onSendButtonPressed ,
            color: isSendButtonEnabled
                ? context.appColors.primary
                : context.appColors.grey_3,
            disabledColor: context.appColors.grey_3,
          ),
        ],
      ).paddingOnly(bottom: 8.h),
    );
  }

  void _onSendButtonPressed() {
    widget.onSendButtonPressed(controller.text);
    controller.clear();
  }
}
