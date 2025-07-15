import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_design/domain/params/open_design_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/open_design_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'open_design_state.dart';

@Injectable()
class OpenDesignCubit extends BaseCubit<OpenDesignState> {
  final OpenDesignUsecase openDesignUsecase;

  OpenDesignCubit(this.openDesignUsecase) : super(OpenDesignState.initial());

  Future<void> openDesign({
    required String projectId,
  }) async {
    if (state.openDesignState.isLoading) return;

    final params = OpenDesignParams(projectId: projectId);

    callAndFold(
      future: openDesignUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(openDesignState: requestState)),
    );
  }
}
