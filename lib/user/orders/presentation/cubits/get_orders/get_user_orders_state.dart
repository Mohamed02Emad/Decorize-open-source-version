part of 'get_user_orders_cubit.dart';


class GetUserOrdersState extends Equatable {
  final RequestState<List<OrderModel>> getUserOrdersState;

  GetUserOrdersState.initial() : getUserOrdersState = RequestState.initial();
  const GetUserOrdersState({required this.getUserOrdersState });

  GetUserOrdersState copyWith({
    RequestState<List<OrderModel>>? getUserOrdersState,
  }) {
    return GetUserOrdersState(
      getUserOrdersState: getUserOrdersState ?? this.getUserOrdersState,
    );
  }

  @override
  List<Object?> get props => [getUserOrdersState ];
}

