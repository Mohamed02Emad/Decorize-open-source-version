part of 'get_profile_cubit.dart';

class GetProfileState extends Equatable {
  final RequestState<User> getProfileState;

  GetProfileState.initial() : getProfileState = RequestState.initial();
  const GetProfileState({required this.getProfileState});

  GetProfileState copyWith({
    RequestState<User>? getProfileState,
  }) {
    return GetProfileState(
      getProfileState: getProfileState ?? this.getProfileState,
    );
  }

  @override
  List<Object?> get props => [getProfileState];
}
