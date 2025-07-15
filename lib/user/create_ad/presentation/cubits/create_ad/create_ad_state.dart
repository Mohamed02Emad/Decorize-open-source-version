part of 'create_ad_cubit.dart';

class CreateAdState extends Equatable {
  final RequestState<Unit> createAdState;

  CreateAdState.initial() : createAdState = RequestState.initial();
  const CreateAdState({required this.createAdState });

  CreateAdState copyWith({
    RequestState<Unit>? createAdState,
  }) {
    return CreateAdState(
      createAdState: createAdState ?? this.createAdState,
    );
  }

  @override
  List<Object?> get props => [createAdState ];
}

