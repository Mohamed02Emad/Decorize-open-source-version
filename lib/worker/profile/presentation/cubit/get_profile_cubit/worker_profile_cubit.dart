import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/worker/home/presentation/cubit/get_orders/get_worker_orders_variables.dart';
import 'package:decorizer/worker/profile/presentation/cubit/get_profile_cubit/worker_profile_variables.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../../common/base/baseCubit.dart';
import '../../../../../common/util/guest_util.dart';
import '../../../../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../../../domain/models/worker_profile_model.dart';
import '../../../domain/params/get_worker_profile_params.dart';
import '../../../domain/usecases/get_worker_profile_usecase.dart';
part 'worker_profile_state.dart';

@Injectable()
class WorkerProfileCubit extends BaseCubit<WorkerProfileState> with WorkerProfileCubitVariables {
  final GetWorkerProfileUseCase workerProfileUsecase;
  final LoginInfoCubit loginInfoCubit;

  WorkerProfileCubit(this.workerProfileUsecase, this.loginInfoCubit)
      : super(WorkerProfileState.initial()){
  }

  Future<void> getWorkerProfile() async {
    if (state.getWorkerProfileState.isLoading || GuestUtil.isGuest) return;
    final cachedId = loginInfoCubit.user!.id;
    final params = GetWorkerProfileParams(workerId: cachedId);
    callAndFold(
        future: workerProfileUsecase(params),
        onDefaultEmit: (requestState) =>
            emit(state.copyWith(getWorkerProfileState: requestState)),
        error: (error) {
          emit(
              state.copyWith(getWorkerProfileState: RequestState.error(error)));
        },
        success: (WorkerProfileModel data) {
          emit(state.copyWith(
              getWorkerProfileState:
              RequestState.success(data)));
        });
  }

}
