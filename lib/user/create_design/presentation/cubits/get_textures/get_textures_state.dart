part of 'get_textures_cubit.dart';

class GetTexturesState extends Equatable {
  final RequestState<List<TextureModel>> getTexturesState;

  GetTexturesState.initial() : getTexturesState = RequestState.initial();

  const GetTexturesState({required this.getTexturesState});

  GetTexturesState copyWith({
    RequestState<List<TextureModel>>? getTexturesState,
  }) {
    return GetTexturesState(
      getTexturesState: getTexturesState ?? this.getTexturesState,
    );
  }

  @override
  List<Object?> get props => [getTexturesState];
}
