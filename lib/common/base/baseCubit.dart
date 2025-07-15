import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../failure.dart';

class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<T?> callAndFold<T>({
    required Future<Either<Failure, T>> future,
    required Function(RequestState<T> requestState) onDefaultEmit,
    Function(String errorMessage)? error,
    Function(T data)? success,
    bool emitLoading = true,
  }) async {
    if (emitLoading) {
      onDefaultEmit(RequestState.loading());
    }
    final result = await future;
    return await result.fold(
      (Failure failure)  {
        if (error != null) {
          error(failure.message);
        } else {
           onDefaultEmit(RequestState.error(failure.message));
        }
        return null;
      },
      (data)  {
        if (success != null) {
          success(data);
        } else {
           onDefaultEmit(RequestState.success(data));
        }
        return data;
      },
    );
  }
}
