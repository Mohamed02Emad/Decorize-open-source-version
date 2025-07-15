import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/create_ad/domain/usecases/create_ad_usecase.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/create_ad/create_ad_cubit_variables.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'create_ad_state.dart';

@Injectable()
class CreateAdCubit extends BaseCubit<CreateAdState>
    with CreateAdCubitVariables {
  final CreateAdUsecase createAdUsecase;
  CreateAdCubit(this.createAdUsecase) : super(CreateAdState.initial());

  Future<void> createAd() async {
    if (state.createAdState.isLoading) return;
    callAndFold(
        future: createAdUsecase(createAdParams),
        onDefaultEmit: (requestState) =>
            emit(state.copyWith(createAdState: requestState)));
  }
}
