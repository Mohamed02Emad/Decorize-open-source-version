import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/usecases/delete_account_use_case.dart';
import '../../../domain/usecases/logout_use_case.dart';

part 'more_state.dart';

@Injectable()
class MoreCubit extends BaseCubit<MoreState> {
  MoreCubit(this._logoutUseCase, this._deleteAccountUseCase)
      : super(MoreState.initial());
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  Future<void> logout() async {
    if (state.logoutState.isLoading) return;
    callAndFold(
      future: _logoutUseCase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(
          state.copyWith(
            logoutState: requestState,
          ),
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    if (state.deleteAccountState.isLoading) return;
    callAndFold(
      future: _deleteAccountUseCase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(
          state.copyWith(
            deleteAccountState: requestState,
          ),
        );
      },
    );
  }
}
