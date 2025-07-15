part of 'more_cubit.dart';

class MoreState extends Equatable {
  final RequestState<Unit> logoutState;
  final RequestState<Unit> deleteAccountState;

  MoreState.initial()
      : logoutState = RequestState.initial(),
        deleteAccountState = RequestState.initial();

  const MoreState(
      {required this.logoutState, required this.deleteAccountState});

  MoreState copyWith({
    RequestState<Unit>? logoutState,
    RequestState<Unit>? deleteAccountState,
  }) {
    return MoreState(
      logoutState: logoutState ?? this.logoutState,
      deleteAccountState: deleteAccountState ?? this.deleteAccountState,
    );
  }

  @override
  List<Object?> get props => [
        logoutState,
        deleteAccountState,
      ];
}
