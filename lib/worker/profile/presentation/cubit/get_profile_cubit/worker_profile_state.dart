part of 'worker_profile_cubit.dart';

class WorkerProfileState extends Equatable {
  final RequestState<WorkerProfileModel> getWorkerProfileState;

  WorkerProfileState.initial() : getWorkerProfileState = RequestState.initial();

  const WorkerProfileState({required this.getWorkerProfileState});

  WorkerProfileState copyWith({
    RequestState<WorkerProfileModel>? getWorkerProfileState,
  }) {
    return WorkerProfileState(
      getWorkerProfileState:
      getWorkerProfileState ?? this.getWorkerProfileState,
    );
  }

  @override
  List<Object?> get props => [getWorkerProfileState];

}