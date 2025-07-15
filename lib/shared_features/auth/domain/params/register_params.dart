import '../enums/user_type.dart';

class RegisterParams {
  final String email, name, password , phone;
  final String? typeId, lat, long, governorateId, cityId , deviceToken;
  final UserType userType;

  RegisterParams( {this.deviceToken, required this.email, required this.name, required this.password, required this.phone, required this.userType, this.typeId, this.lat, this.long, this.governorateId, this.cityId});

  RegisterParams copyWith({
    String? email,
    String? name,
    String? password,
    String? phone,
    String? typeId,
    String? lat,
    String? long,
    String? governorateId,
    String? cityId,
    String? deviceToken,
    UserType? userType,
  }) {
    return RegisterParams(
      deviceToken: deviceToken ?? this.deviceToken,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      typeId: typeId ?? this.typeId,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      governorateId: governorateId ?? this.governorateId,
      cityId: cityId ?? this.cityId,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'type': userType.apiName,
        'phone': phone,
         "type_id": typeId,
        'password': password,
        'password_confirmation': password,
        'lat': lat,
        'long': long,
        'governorate_id': governorateId,
        'city_id': cityId,
        'device_token': deviceToken,
      };
}
