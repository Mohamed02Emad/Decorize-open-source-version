part of 'cities_cubit.dart';


class CitiesState extends Equatable {
  final RequestState<List<CityModel>> citiesState;

  CitiesState.initial() : citiesState = RequestState.initial();
  const CitiesState({required this.citiesState });

  CitiesState copyWith({
    RequestState<List<CityModel>>? citiesState,
  }) {
    return CitiesState(
      citiesState: citiesState ?? this.citiesState,
    );
  }

  @override
  List<Object?> get props => [citiesState ];
}

