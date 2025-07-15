part of 'open_design_cubit.dart';

class OpenDesignState extends Equatable {
  final RequestState<Unit> openDesignState;

  OpenDesignState.initial() : openDesignState = RequestState.initial();
  const OpenDesignState({required this.openDesignState});

  OpenDesignState copyWith({
    RequestState<Unit>? openDesignState,
  }) {
    return OpenDesignState(
      openDesignState: openDesignState ?? this.openDesignState,
    );
  }

  @override
  List<Object?> get props => [openDesignState];
}
