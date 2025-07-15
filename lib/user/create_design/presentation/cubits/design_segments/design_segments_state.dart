part of 'design_segments_cubit.dart';

class DesignSegmentsState extends Equatable {
  final RequestState<DesignSegmentsModel> designSegmentsState;
  final RequestState<String> changeSegmentColorState;
  final RequestState<String> changeSegmentTextureState;

  DesignSegmentsState.initial()
      : designSegmentsState = RequestState.initial(),
        changeSegmentColorState = RequestState.initial(),
        changeSegmentTextureState = RequestState.initial();

  const DesignSegmentsState({
    required this.designSegmentsState,
    required this.changeSegmentColorState,
    required this.changeSegmentTextureState,
  });

  DesignSegmentsState copyWith({
    RequestState<DesignSegmentsModel>? designSegmentsState,
    RequestState<String>? changeSegmentColorState,
    RequestState<String>? changeSegmentTextureState,
  }) {
    return DesignSegmentsState(
      designSegmentsState: designSegmentsState ?? this.designSegmentsState,
      changeSegmentColorState:
          changeSegmentColorState ?? this.changeSegmentColorState,
      changeSegmentTextureState:
          changeSegmentTextureState ?? this.changeSegmentTextureState,
    );
  }

  @override
  List<Object?> get props =>
      [designSegmentsState, changeSegmentColorState, changeSegmentTextureState];
}
