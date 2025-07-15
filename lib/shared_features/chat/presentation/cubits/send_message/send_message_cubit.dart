import 'package:dartz/dartz.dart';
import 'package:decorizer/shared_features/chat/domain/enums/message_status.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/send_message_params.dart';
import 'package:decorizer/shared_features/chat/domain/usecases/send_message_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';

part 'send_message_state.dart';

@Injectable()
class SendMessageCubit extends BaseCubit<SendMessageState> {
  SendMessageCubit(
    this.sendMessageUseCase,
  ) : super(SendMessageState.initial());
  final SendMessageUseCase sendMessageUseCase;

  Future<void> sendMessage({required MessageModel localMessage}) async {
    if (state.sendMessageState.isLoading) return;
    final params = SendMessageParams(
      conversationId: localMessage.chatId.toString(),
      message: localMessage.message ?? '',
    );
    callAndFold(
      future: sendMessageUseCase(params),
      onDefaultEmit: (requestState) => emit(
        state.copyWith(sendMessageState: requestState),
      ),
      success: (MessageModel messageModel) {
        final updatedMessage = messageModel.copyWith( status: MessageStatus.sent, localId: localMessage.localId);
        emit(state.copyWith(sendMessageState: RequestState.success(updatedMessage)));
      },
      error: (error) {
        final updatedMessage = localMessage.copyWith( status: MessageStatus.failed, localId: localMessage.localId);
        emit(state.copyWith( sendMessageState: RequestState.error(error.toString(), data: updatedMessage)));
      },
    );
  }
}
