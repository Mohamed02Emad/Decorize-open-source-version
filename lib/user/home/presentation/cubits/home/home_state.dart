part of 'home_cubit.dart';

class HomeState extends Equatable {
  final RequestState<List<CategoryModel>> categoriesState;
  final RequestState<List<ImageModel>> categoriesImagesState;
  final RequestState<List<ImageModel>> savedDesignsState;

  const HomeState({
    required this.categoriesState,
    required this.categoriesImagesState,
    required this.savedDesignsState,
  });

  factory HomeState.initial() {
    return HomeState(
      categoriesState: RequestState.initial(),
      categoriesImagesState: RequestState.initial(),
      savedDesignsState: RequestState.initial(),
    );
  }

  HomeState copyWith({
    RequestState<List<CategoryModel>>? categoriesState,
    RequestState<List<ImageModel>>? categoriesImagesState,
    RequestState<List<ImageModel>>? savedDesignsState,
  }) {
    return HomeState(
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesImagesState:
          categoriesImagesState ?? this.categoriesImagesState,
      savedDesignsState: savedDesignsState ?? this.savedDesignsState,
    );
  }

  bool get isHomeError =>
      categoriesState.isError ||
      categoriesImagesState.isError ||
      savedDesignsState.isError;

  bool get isCategoriesListLoading =>
      categoriesState.isLoading ||
      categoriesImagesState.isLoading ||
      categoriesImagesState.isInit;

  @override
  List<Object?> get props =>
      [categoriesState, categoriesImagesState, savedDesignsState];
}
