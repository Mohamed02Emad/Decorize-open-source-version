part of 'governates_cubit.dart';


class GovernatesState extends Equatable {
  final RequestState<List<GovernorateModel>> governatesState;

  GovernatesState.initial() : governatesState = RequestState.initial();
  const GovernatesState({required this.governatesState });

  GovernatesState copyWith({
    RequestState<List<GovernorateModel>>? governatesState,
  }) {
    return GovernatesState(
      governatesState: governatesState ?? this.governatesState,
    );
  }

  @override
  List<Object?> get props => [governatesState ];
}

