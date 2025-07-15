import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_design/domain/models/suggest_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/suggest_design_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/suggest_design_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'suggest_design_state.dart';

@Injectable()
class SuggestDesignCubit extends BaseCubit<SuggestDesignState> {
  final SuggestDesignUsecase suggestDesignUsecase;

  SuggestDesignCubit(this.suggestDesignUsecase)
      : super(SuggestDesignState.initial());

  Future<void> suggestDesign({
    required String projectId,
    required File image,
    required String promptArabic,
    required bool isRecreate,
    String? fileId,
  }) async {
    if (state.suggestDesignState.isLoading) return;

    final params = SuggestDesignParams(
        projectId: projectId,
        image: image,
        promptArabic: promptArabic,
        isRecreate: isRecreate,
        fileId: fileId);

    callAndFold(
      future: suggestDesignUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(suggestDesignState: requestState)),
    );
  }
}
