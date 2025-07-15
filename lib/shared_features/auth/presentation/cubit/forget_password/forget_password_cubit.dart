import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/shared_features/auth/domain/params/forget_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/forget_password_use_case.dart';

import 'package:injectable/injectable.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/models/responses/auth_response.dart';

part 'forget_password_state.dart';

@Injectable()
class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState> {
  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
  ) : super(ForgetPasswordState.initial());
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  Future<void> forgetPassword(ForgetPasswordParams params) async {
    if (state.forgetPasswordState.isLoading) return;
    callAndFold(
      future: _forgetPasswordUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(forgetPasswordState: requestState));
      },
    );
  }
}
