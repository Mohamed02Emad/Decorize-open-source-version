import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_design/domain/params/exit_design_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/exit_design_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'exit_design_state.dart';

@Injectable()
class ExitDesignCubit extends BaseCubit<ExitDesignState> {
  final ExitDesignUsecase exitDesignUsecase;

  ExitDesignCubit(this.exitDesignUsecase) : super(ExitDesignState.initial());

  Future<void> exitDesign({
    required String projectId,
  }) async {
    if (state.exitDesignState.isLoading) return;

    final params = ExitDesignParams(projectId: projectId);

    callAndFold(
      future: exitDesignUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(exitDesignState: requestState)),
    );
  }
}
