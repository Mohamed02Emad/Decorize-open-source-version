part of 'types_cubit.dart';


class TypesState extends Equatable {
  final RequestState<List<TypeModel>> typesState;

  TypesState.initial() : typesState = RequestState.initial();
  const TypesState({required this.typesState });

  TypesState copyWith({
    RequestState<List<TypeModel>>? typesState,
  }) {
    return TypesState(
      typesState: typesState ?? this.typesState,
    );
  }

  @override
  List<Object?> get props => [typesState ];
}

