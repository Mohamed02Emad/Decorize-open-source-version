import 'package:decorizer/common/data/localization_name_model.dart';

List<GovernorateModel> governoratesFromJson(List<dynamic> json) {
  return json.map((e) => GovernorateModel.fromJson(e)).toList();
}

class GovernorateModel{
  final int id;
  final LocalizedTextModel name;

  GovernorateModel({required this.id, required this.name});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
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

