import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/register_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/models/responses/auth_response.dart';
import '../../../domain/usecases/setters/set_cached_user_usecase.dart';
import '../../../domain/usecases/setters/set_user_token_usecase.dart';

part 'register_state.dart';

@Injectable()
class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit(this._registerUseCase, this._setUserTokenUseCase,
      this._setCachedUserUseCase)
      : super(RegisterState.initial());
  final RegisterUseCase _registerUseCase;
  final SetUserTokenUseCase _setUserTokenUseCase;
  final SetCachedUserUseCase _setCachedUserUseCase;

  Future<void> register(RegisterParams params) async {
    if (state.registerState.isLoading) return;
    callAndFold(
      future: _registerUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(registerState: requestState));
      },
    );
  }

  Future<void> cacheUserData(AuthResponse authResponse) async {
    await _setUserTokenUseCase(authResponse.accessToken);
    await _setCachedUserUseCase(authResponse.user);
  }
}
