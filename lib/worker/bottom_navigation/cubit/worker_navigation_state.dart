part of 'worker_navigation_cubit.dart';

class WorkerNavigationState extends Equatable {
  final RequestState<Unit> navState;

  WorkerNavigationState.initial() : navState = RequestState.initial();
  const WorkerNavigationState({required this.navState});

  WorkerNavigationState copyWith({
    RequestState<Unit>? navState,
  }) {
    return WorkerNavigationState(
      navState: navState ?? this.navState,
    );
  }

  @override
  List<Object?> get props => [navState];
}
