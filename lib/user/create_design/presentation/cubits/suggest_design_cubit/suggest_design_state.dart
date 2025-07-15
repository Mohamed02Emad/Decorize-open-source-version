part of 'suggest_design_cubit.dart';

class SuggestDesignState extends Equatable {
  final RequestState<SuggestDesignModel> suggestDesignState;

  const SuggestDesignState({
    required this.suggestDesignState,
  });

  factory SuggestDesignState.initial() {
    return SuggestDesignState(
      suggestDesignState: RequestState.initial(),
    );
  }

  SuggestDesignState copyWith({
    RequestState<SuggestDesignModel>? suggestDesignState,
  }) {
    return SuggestDesignState(
      suggestDesignState: suggestDesignState ?? this.suggestDesignState,
    );
  }

  @override
  List<Object?> get props => [suggestDesignState];
}
