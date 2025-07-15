import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/shared_features/static/domain/usecases/types_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'types_state.dart';

@Injectable()
class TypesCubit extends BaseCubit<TypesState> {
  final TypesUsecase typesUsecase;
  TypesCubit(this.typesUsecase) : super(TypesState.initial());

  Future<void> getTypes() async {
    if (state.typesState.isLoading) return;
    await callAndFold(
      future: typesUsecase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(typesState: requestState));
      },
    );
  }
}
