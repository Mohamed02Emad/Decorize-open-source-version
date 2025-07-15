import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:equatable/equatable.dart';

class AllDesignsState extends Equatable {
  final RequestState<List<ImageModel>> allDesignsState;

  const AllDesignsState({
    required this.allDesignsState,
  });

  factory AllDesignsState.initial() {
    return AllDesignsState(
      allDesignsState: RequestState.initial(),
    );
  }

  AllDesignsState copyWith({
    RequestState<List<ImageModel>>? allDesignsState,
  }) {
    return AllDesignsState(
      allDesignsState: allDesignsState ?? this.allDesignsState,
    );
  }

  @override
  List<Object?> get props => [allDesignsState];
}
