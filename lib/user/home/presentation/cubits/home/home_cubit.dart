import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/static/domain/models/category_model.dart';
import 'package:decorizer/shared_features/static/domain/usecases/categories_usecase.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';
import 'package:decorizer/user/home/domain/usecases/get_saved_designs_usecase.dart';
import 'package:decorizer/user/home/domain/usecases/suggested_designs_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState> {
  final CategoriesUsecase categoriesUsecase;
  final SuggestedDesignsUsecase suggestedDesignsUsecase;
  final GetSavedDesignsUsecase getSavedDesignsUsecase;

  final ScrollController scrollController = ScrollController();

  HomeCubit(
    this.categoriesUsecase,
    this.suggestedDesignsUsecase,
    this.getSavedDesignsUsecase,
  ) : super(HomeState.initial());

  final ValueNotifier<CategoryModel?> selectedCategory = ValueNotifier(null);

  Future<void> getCategories() async {
    if (state.categoriesState.isLoading) return;
    await callAndFold(
      future: categoriesUsecase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(categoriesState: requestState));
      },
    );
    if (state.categoriesState.data?.isNotEmpty == true) {
      selectedCategory.value = state.categoriesState.data?.first;
      getSuggestedDesigns();
    }
  }

  Future<void> getSuggestedDesigns() async {
    if (state.categoriesImagesState.isLoading) return;
    await callAndFold(
      future: suggestedDesignsUsecase(
          SuggestedDesignsParams(categoryId: selectedCategory.value?.id ?? 0)),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(categoriesImagesState: requestState));
      },
    );
  }

  Future<void> getSavedDesigns() async {
    if (state.savedDesignsState.isLoading) return;
    await callAndFold(
      future: getSavedDesignsUsecase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(savedDesignsState: requestState));
      },
    );
  }

  Future<void> refresh() async {
    await Future.wait([getCategories(), getSavedDesigns()]);
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory.value = category;
    getSuggestedDesigns();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
