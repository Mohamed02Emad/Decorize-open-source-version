import 'package:decorizer/common/data/localization_name_model.dart';

List<CityModel> citiesFromJson(List<dynamic> json) {
  return json.map((e) => CityModel.fromJson(e)).toList();
}

class CityModel{
  final int id;
  final LocalizedTextModel name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: LocalizedTextModel.fromJson(json['multi_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'multi_name': name.toJson(),
    };
  }


}

