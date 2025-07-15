import 'dart:convert';

import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';

class User {
  final int id;
  final String name;
  final String email;
  final UserType type;
  final String? profession;
  final String phone;
  final int status;
  final bool isVerified;
  final String? image;
  final String? lat;
  final String? long;
  final int? governorateId;
  final int? cityId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.profession,
    required this.phone,
    required this.status,
    required this.isVerified,
    required this.image,
    required this.lat,
    required this.long,
    required this.governorateId,
    required this.cityId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        type: UserType.fromString(json["type"]),
        profession: json["profession"],
        phone: json["phone"],
        status: json["status"],
        isVerified: json["is_verified"],
        image: json["image"],
        lat: json["lat"],
        long: json["long"],
    governorateId: json["governorate_id"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "type": type.name,
    "profession": profession,
        "phone": phone,
        "status": status,
        "is_verified": isVerified,
        "image": image,
        "lat": lat,
        "long": long,
        "governorate_id": governorateId,
        "city_id": cityId,
      };

  User copyWith({
    int? id,
    String? name,
    String? email,
    UserType? type,
    String? profession,
    String? phone,
    int? status,
    bool? isVerified,
    String? image,
    String? lat,
    String? long,
    int? governorateId,
    int? cityId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      profession: profession ?? this.profession,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      governorateId: governorateId ?? this.governorateId,
      cityId: cityId ?? this.cityId,
    );
  }

  factory User.fromCacheString(String userString) {
    return User.fromJson(jsonDecode(userString));
  }

  String toCacheString() {
    return jsonEncode(toJson());
  }
}
