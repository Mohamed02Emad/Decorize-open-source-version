part of 'login_info_cubit.dart';

class LoginInfoState extends Equatable {
  final RequestState<User?> userState;

  LoginInfoState.initial() : userState = RequestState.initial();

  const LoginInfoState({required this.userState});

  LoginInfoState copyWith({
    RequestState<User?>? userState,
  }) {
    return LoginInfoState(
      userState: userState ?? this.userState,
    );
  }

  @override
  List<Object?> get props => [userState];
}
