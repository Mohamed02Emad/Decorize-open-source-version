part of 'save_design_cubit.dart';

class SaveDesignState extends Equatable {
  final RequestState<Unit> saveDesignState;

  SaveDesignState.initial() : saveDesignState = RequestState.initial();
  const SaveDesignState({required this.saveDesignState});

  SaveDesignState copyWith({
    RequestState<Unit>? saveDesignState,
  }) {
    return SaveDesignState(
      saveDesignState: saveDesignState ?? this.saveDesignState,
    );
  }

  @override
  List<Object?> get props => [saveDesignState];
}
