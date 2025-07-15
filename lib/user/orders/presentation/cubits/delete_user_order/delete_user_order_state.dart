part of 'delete_user_order_cubit.dart';

class DeleteUserOrderState extends Equatable {
  final RequestState<Unit> deleteUserOrderState;

  DeleteUserOrderState.initial() : deleteUserOrderState = RequestState.initial();
  const DeleteUserOrderState({required this.deleteUserOrderState });

  DeleteUserOrderState copyWith({
    RequestState<Unit>? deleteUserOrderState,
  }) {
    return DeleteUserOrderState(
      deleteUserOrderState: deleteUserOrderState ?? this.deleteUserOrderState,
    );
  }

  @override
  List<Object?> get props => [deleteUserOrderState ];
}
