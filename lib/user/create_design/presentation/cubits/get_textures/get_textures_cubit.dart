import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_design/domain/models/texture_model.dart';
import 'package:decorizer/user/create_design/domain/params/get_textures_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/get_textures_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'get_textures_state.dart';

@Injectable()
class GetTexturesCubit extends BaseCubit<GetTexturesState> {
  final GetTexturesUsecase getTexturesUsecase;

  GetTexturesCubit(this.getTexturesUsecase) : super(GetTexturesState.initial());

  Future<void> getTextures() async {
    if (state.getTexturesState.isLoading) return;

    final params = GetTexturesParams();

    callAndFold(
      future: getTexturesUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(getTexturesState: requestState)),
    );
  }
}
