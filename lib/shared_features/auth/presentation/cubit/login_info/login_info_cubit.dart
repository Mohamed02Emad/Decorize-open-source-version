import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/models/user.dart';
import '../../../domain/usecases/getters/get_cached_user_use_case.dart';
import '../../../domain/usecases/getters/get_is_onboarding_finished_usecase.dart';
import '../../../domain/usecases/getters/get_user_token_usecase.dart';
import '../../../domain/usecases/setters/set_is_onboarding_finished_usecase.dart';

part 'login_info_state.dart';

@Singleton()
class LoginInfoCubit extends BaseCubit<LoginInfoState> {
  LoginInfoCubit(
      this._isOnboardingFinishedUseCase,
      this._setIsOnboardingFinishedUseCase,
      this._getUserTokenUseCase,
      this._getCachedUserUseCase)
      : super(LoginInfoState.initial());
  final GetIsOnboardingFinishedUseCase _isOnboardingFinishedUseCase;
  final SetIsOnboardingFinishedUseCase _setIsOnboardingFinishedUseCase;
  final GetUserTokenUseCase _getUserTokenUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  User? _user;

  User? get user => _user;

  bool _hasUser = false;
  bool _isGuest = false;
  bool _finishedOnBoarding = false;

  bool get isGuest => _isGuest;

  bool get hasUser => _hasUser;

  bool get finishedOnBoarding => _finishedOnBoarding;

  Future<void> init() async {
    emit(state.copyWith(userState: RequestState.loading()));
    final Either<Failure, String?> hasUserResult =
        await _getUserTokenUseCase(NoParams());
    hasUserResult.fold(
        (l) => _hasUser = false, (r) => _hasUser = r != null && r.isNotEmpty);

    final Either<Failure, bool> finishedOnboardingResult =
        await _isOnboardingFinishedUseCase(NoParams());
    finishedOnboardingResult.fold((l) {
      _finishedOnBoarding = false;
    }, (r) {
      _finishedOnBoarding = r;
    });

    _isGuest = _hasUser.not();

    final result = await _getCachedUserUseCase(NoParams());
    result.fold((l) {}, (r) {
      _user = r;
    });

    emit(state.copyWith(userState: RequestState.success(_user)));
  }

  void finishOnBoarding() {
    _setIsOnboardingFinishedUseCase(true);
    init();
  }

  void clearCachedData() {
    _user = null;
    _hasUser = false;
    _isGuest = true;
    emit(state.copyWith(userState: RequestState.success(_user)));
  }

  void updateUser(User user) {
    _user = user;
    emit(state.copyWith(userState: RequestState.success(_user)));
  }
}
