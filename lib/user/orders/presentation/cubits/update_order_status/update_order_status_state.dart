part of 'update_order_status_cubit.dart';

class UpdateOrderStatusState extends Equatable {
  final RequestState<Unit> startWorkState;
  final RequestState<Unit> cancelOrderState;
  final RequestState<Unit> endWorkState;

  UpdateOrderStatusState.initial() : startWorkState = RequestState.initial(), cancelOrderState = RequestState.initial(), endWorkState = RequestState.initial();
  const UpdateOrderStatusState({required this.startWorkState, required this.cancelOrderState, required this.endWorkState });

  UpdateOrderStatusState copyWith({
    RequestState<Unit>? startWorkState,
    RequestState<Unit>? cancelOrderState,
    RequestState<Unit>? endWorkState,
  }) {
    return UpdateOrderStatusState(
      startWorkState: startWorkState ?? this.startWorkState,
      cancelOrderState: cancelOrderState ?? this.cancelOrderState,
      endWorkState: endWorkState ?? this.endWorkState,
    );
  }

  @override
  List<Object?> get props => [startWorkState, cancelOrderState, endWorkState];
}
