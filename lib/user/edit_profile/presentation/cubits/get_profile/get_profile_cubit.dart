import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/auth/domain/models/user.dart';
import 'package:decorizer/user/edit_profile/domain/params/get_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/usecases/get_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'get_profile_state.dart';

@injectable
class GetProfileCubit extends BaseCubit<GetProfileState> {
  final GetProfileUsecase getProfileUsecase;

  GetProfileCubit(this.getProfileUsecase) : super(GetProfileState.initial());

  Future<void> getProfile(String userId) async {
    callAndFold(
      future: getProfileUsecase(GetProfileParams(userId: userId)),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(getProfileState: requestState)),
      error: (error) {
        emit(state.copyWith(getProfileState: RequestState.error(error)));
      },
      success: (user) {
        emit(state.copyWith(getProfileState: RequestState.success(user)));
      },
    );
  }
}
