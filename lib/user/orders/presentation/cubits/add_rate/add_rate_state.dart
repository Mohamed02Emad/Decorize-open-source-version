part of 'add_rate_cubit.dart';

class AddRateState extends Equatable {
  final RequestState<Unit> addRateState;

  AddRateState.initial() : addRateState = RequestState.initial();
  const AddRateState({ required this.addRateState });

  AddRateState copyWith({
    RequestState<Unit>? addRateState,
  }) {
    return AddRateState(
      addRateState: addRateState ?? this.addRateState,
    );
  }

  @override
  List<Object?> get props => [addRateState];
}
