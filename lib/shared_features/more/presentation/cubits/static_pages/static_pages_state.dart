part of 'static_pages_cubit.dart';

class StaticPagesState extends Equatable {
  final RequestState<StaticPageResponse> staticPagesState;

  StaticPagesState.initial() : staticPagesState = RequestState.initial();

  const StaticPagesState._({required this.staticPagesState});

  StaticPagesState copyWith({
    RequestState<StaticPageResponse>? staticPagesState,
  }) {
    return StaticPagesState._(
      staticPagesState: staticPagesState ?? this.staticPagesState,
    );
  }

  @override
  List<Object?> get props => [
        staticPagesState,
      ];
}
