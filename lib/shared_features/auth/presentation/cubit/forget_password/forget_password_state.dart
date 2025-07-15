part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final RequestState<AuthResponse> forgetPasswordState;

  ForgetPasswordState.initial() : forgetPasswordState = RequestState.initial();
  const ForgetPasswordState({required this.forgetPasswordState });

  ForgetPasswordState copyWith({
    RequestState<AuthResponse>? forgetPasswordState,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
    );
  }

  @override
  List<Object?> get props => [forgetPasswordState ];
}

