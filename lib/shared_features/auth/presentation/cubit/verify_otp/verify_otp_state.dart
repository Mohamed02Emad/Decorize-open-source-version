part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  final RequestState<AuthResponse> verifyState;

  VerifyOtpState.initial() : verifyState = RequestState.initial();
  const VerifyOtpState({required this.verifyState });

  VerifyOtpState copyWith({
    RequestState<AuthResponse>? verifyState,
  }) {
    return VerifyOtpState(
      verifyState: verifyState ?? this.verifyState,
    );
  }

  @override
  List<Object?> get props => [verifyState ];
}

