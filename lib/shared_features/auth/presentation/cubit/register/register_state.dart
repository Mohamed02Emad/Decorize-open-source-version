part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final RequestState<AuthResponse> registerState;

  RegisterState.initial() : registerState = RequestState.initial();
  const RegisterState({required this.registerState });

  RegisterState copyWith({
    RequestState<AuthResponse>? registerState,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
    );
  }

  @override
  List<Object?> get props => [registerState ];
}

