import 'package:dartz/dartz.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/create_chat_params.dart';
import 'package:decorizer/shared_features/chat/domain/usecases/create_chat_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';

part 'create_chat_state.dart';

@Injectable()
class CreateChatCubit extends BaseCubit<CreateChatState> {
  CreateChatCubit(
    this.createChatUseCase,
  ) : super(CreateChatState.initial());

  final CreateChatUseCase createChatUseCase;

  Future<void> createChat(CreateChatParams params) async {
    if (state.createChatState.isLoading) return;
    callAndFold(
      future: createChatUseCase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(createChatState: requestState)),
    );
  }
}
