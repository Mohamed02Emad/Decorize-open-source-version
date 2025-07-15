import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/shared_features/static/domain/usecases/categories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'categories_state.dart';

@Injectable()
class CategoriesCubit extends BaseCubit<CategoriesState> {
  final CategoriesUsecase categoriesUsecase;
  CategoriesCubit(this.categoriesUsecase) : super(CategoriesState.initial());

  Future<void> getCategories() async {
    if (state.categoriesState.isLoading) return;
    await callAndFold(
      future: categoriesUsecase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(categoriesState: requestState));
      },
    );
  }
}
