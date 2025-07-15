import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/shared_features/auth/domain/params/login_params.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/login_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/models/responses/auth_response.dart';
import '../../../domain/usecases/setters/set_cached_user_usecase.dart';
import '../../../domain/usecases/setters/set_user_token_usecase.dart';

part 'login_state.dart';

@Injectable()
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(
      this._loginUseCase, this._setUserTokenUseCase, this._setCachedUserUseCase)
      : super(LoginState.initial());
  final LoginUseCase _loginUseCase;
  final SetUserTokenUseCase _setUserTokenUseCase;
  final SetCachedUserUseCase _setCachedUserUseCase;

  Future<void> login(LoginParams params) async {
    if (state.loginState.isLoading) return;
    callAndFold(
      future: _loginUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(loginState: requestState));
      },
      success: (data) async {
        if(data.verificationCode == null) {
          await cacheUserData(data);
        }
        emit(state.copyWith(loginState: RequestState.success(data)));
      },
    );
  }

  Future<void> cacheUserData(AuthResponse authResponse) async {
    final tokenResult = await _setUserTokenUseCase(authResponse.accessToken);
    final userResult = await _setCachedUserUseCase(authResponse.user);
    if (tokenResult.isLeft() || userResult.isLeft()) {
      emit(state.copyWith(
          loginState: RequestState.error(tr(LocaleKeys.error_error_happened))));
    }
  }
}
