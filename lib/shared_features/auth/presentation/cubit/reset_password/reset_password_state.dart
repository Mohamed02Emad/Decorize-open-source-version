part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final RequestState<Unit> resetPasswordState;

  ResetPasswordState.initial() : resetPasswordState = RequestState.initial();
  const ResetPasswordState({required this.resetPasswordState });

  ResetPasswordState copyWith({
    RequestState<Unit>? resetPasswordState,
  }) {
    return ResetPasswordState(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [resetPasswordState ];
}

