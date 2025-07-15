import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/remote/request_state.dart';

part 'reset_password_state.dart';

@Injectable()
class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  ResetPasswordCubit(
    this._resetPasswordUseCase,
  ) : super(ResetPasswordState.initial());
  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> resetPassword(ResetPasswordParams params) async {
    if (state.resetPasswordState.isLoading) return;
    callAndFold(
      future: _resetPasswordUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(resetPasswordState: requestState));
      },
    );
  }
}
