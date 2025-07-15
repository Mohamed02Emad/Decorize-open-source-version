part of 'exit_design_cubit.dart';

class ExitDesignState extends Equatable {
  final RequestState<Unit> exitDesignState;

  ExitDesignState.initial() : exitDesignState = RequestState.initial();
  const ExitDesignState({required this.exitDesignState});

  ExitDesignState copyWith({
    RequestState<Unit>? exitDesignState,
  }) {
    return ExitDesignState(
      exitDesignState: exitDesignState ?? this.exitDesignState,
    );
  }

  @override
  List<Object?> get props => [exitDesignState];
}
