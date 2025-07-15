import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:equatable/equatable.dart';

class SavedDesignsState extends Equatable {
  final RequestState<List<ImageModel>> savedDesignsState;

  const SavedDesignsState({
    required this.savedDesignsState,
  });

  factory SavedDesignsState.initial() {
    return SavedDesignsState(
      savedDesignsState: RequestState.initial(),
    );
  }

  SavedDesignsState copyWith({
    RequestState<List<ImageModel>>? savedDesignsState,
  }) {
    return SavedDesignsState(
      savedDesignsState: savedDesignsState ?? this.savedDesignsState,
    );
  }

  @override
  List<Object?> get props => [savedDesignsState];
}
