import 'package:decorizer/common/data/localization_name_model.dart';

List<TypeModel> typesFromJson(List<dynamic> json) {
  return json.map((e) => TypeModel.fromJson(e)).toList();
}

class TypeModel{
  final int id;
  final LocalizedTextModel name;

  TypeModel({required this.id, required this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'],
      name: json['multi_name'] == null ? LocalizedTextModel(en: json['name'], ar: json['name']) : LocalizedTextModel.fromJson(json['multi_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'multi_name': name.toJson(),
    };
  }


}

