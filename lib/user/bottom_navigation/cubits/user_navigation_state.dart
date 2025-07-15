part of 'user_navigation_cubit.dart';

class UserNavigationState extends Equatable {
  final RequestState<Unit> navState;

  UserNavigationState.initial() : navState = RequestState.initial();
  const UserNavigationState({required this.navState});

  UserNavigationState copyWith({
    RequestState<Unit>? navState,
  }) {
    return UserNavigationState(
      navState: navState ?? this.navState,
    );
  }

  @override
  List<Object?> get props => [navState];
}
