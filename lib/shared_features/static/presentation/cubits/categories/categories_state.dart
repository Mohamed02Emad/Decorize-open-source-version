part of 'categories_cubit.dart';


class CategoriesState extends Equatable {
  final RequestState<List<CategoryModel>> categoriesState;

  CategoriesState.initial() : categoriesState = RequestState.initial();
  const CategoriesState({required this.categoriesState });

  CategoriesState copyWith({
    RequestState<List<CategoryModel>>? categoriesState,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
    );
  }

  @override
  List<Object?> get props => [categoriesState ];
}

