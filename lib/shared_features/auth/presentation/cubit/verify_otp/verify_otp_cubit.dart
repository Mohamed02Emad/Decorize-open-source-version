import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';
import 'package:decorizer/shared_features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/models/responses/auth_response.dart';

part 'verify_otp_state.dart';

@Injectable()
class VerifyOtpCubit extends BaseCubit<VerifyOtpState> {
  VerifyOtpCubit(
    this._verifyOtpUseCase,
  ) : super(VerifyOtpState.initial());
  final VerifyOtpUseCase _verifyOtpUseCase;

  Future<void> verifyOtp(VerifyOtpParams params) async {
    if (state.verifyState.isLoading) return;
    callAndFold(
      future: _verifyOtpUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(verifyState: requestState));
      },
    );
  }
}
