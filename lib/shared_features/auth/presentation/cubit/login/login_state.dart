part of 'login_cubit.dart';

class LoginState extends Equatable {
  final RequestState<AuthResponse> loginState;

  LoginState.initial() : loginState = RequestState.initial();
  const LoginState({required this.loginState });

  LoginState copyWith({
    RequestState<AuthResponse>? loginState,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
    );
  }

  @override
  List<Object?> get props => [loginState ];
}

