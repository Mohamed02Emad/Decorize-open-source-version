import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/params/get_cities_params.dart';
import 'package:decorizer/shared_features/static/domain/usecases/cities_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'cities_state.dart';

@Injectable()
class CitiesCubit extends BaseCubit<CitiesState> {
  final CitiesUsecase citiesUsecase;
  CitiesCubit(this.citiesUsecase) : super(CitiesState.initial());

  Future<void> getCities(int governorateId) async {
    if (state.citiesState.isLoading) return;
    await callAndFold(
      future: citiesUsecase(GetCitiesParams(governorateId: governorateId)),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(citiesState: requestState));
      },
    );
  }
}
