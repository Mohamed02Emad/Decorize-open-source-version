import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/usecases/governates_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'governates_state.dart';

@Injectable()
class GovernatesCubit extends BaseCubit<GovernatesState> {
  final GovernatesUsecase governatesUsecase;
  GovernatesCubit(this.governatesUsecase) : super(GovernatesState.initial());

  Future<void> getGovernorates() async {
    if (state.governatesState.isLoading) return;
    await callAndFold(
      future: governatesUsecase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(governatesState: requestState));
      },
    );
  }
}
