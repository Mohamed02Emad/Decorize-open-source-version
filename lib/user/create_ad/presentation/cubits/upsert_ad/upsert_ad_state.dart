part of 'upsert_ad_cubit.dart';

class UpsertAdState extends Equatable {
  final RequestState<Unit> upsertAdState;

  UpsertAdState.initial() : upsertAdState = RequestState.initial();
  const UpsertAdState({required this.upsertAdState});

  UpsertAdState copyWith({
    RequestState<Unit>? upsertAdState,
  }) {
    return UpsertAdState(
      upsertAdState: upsertAdState ?? this.upsertAdState,
    );
  }

  @override
  List<Object?> get props => [upsertAdState];
}
