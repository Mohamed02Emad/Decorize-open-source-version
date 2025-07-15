part of 'user_order_details_cubit.dart';


class UserOrderDetailsState extends Equatable {
  final RequestState<OrderDetailsModel> orderDetailsState;

  UserOrderDetailsState.initial() : orderDetailsState = RequestState.initial();
  const UserOrderDetailsState({required this.orderDetailsState });

  UserOrderDetailsState copyWith({
    RequestState<OrderDetailsModel>? orderDetailsState,
  }) {
    return UserOrderDetailsState(
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
    );
  }

  @override
  List<Object?> get props => [orderDetailsState ];
}