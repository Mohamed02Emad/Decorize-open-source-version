part of 'mark_as_read_cubit.dart';

class MarkAsReadState extends Equatable {
  final RequestState<Unit> markAsReadState;

  MarkAsReadState.initial() : markAsReadState = RequestState.initial();
  const MarkAsReadState({required this.markAsReadState});

  MarkAsReadState copyWith({
    RequestState<Unit>? markAsReadState,
  }) {
    return MarkAsReadState(
      markAsReadState: markAsReadState ?? this.markAsReadState,
    );
  }

  @override
  List<Object?> get props => [markAsReadState];
}
