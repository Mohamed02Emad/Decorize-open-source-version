import 'package:decorizer/common/data/localization_name_model.dart';
import 'package:decorizer/common/data/models/image_model.dart';

List<CategoryModel> categoriesFromJson(List<dynamic> json) {
  return json.map((e) => CategoryModel.fromJson(e)).toList();
}

class CategoryModel{
  final int id;
  final ImageModel? image;
  final LocalizedTextModel name;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['multi_name'] == null ? LocalizedTextModel(en: json['name'], ar: json['name']) : LocalizedTextModel.fromJson(json['multi_name']),
       image: json['image'] == null ? null : ImageModel.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'multi_name': name.toJson(),
    };
  }


}

