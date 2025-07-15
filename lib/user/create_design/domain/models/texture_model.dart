import 'package:equatable/equatable.dart';

class TextureModel extends Equatable {
  final int id;
  final String title;
  final String image;

  const TextureModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory TextureModel.fromJson(Map<String, dynamic> json) {
    return TextureModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, title, image];
}

// Helper function to parse list of textures from JSON
List<TextureModel> texturesFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => TextureModel.fromJson(json)).toList();
}
