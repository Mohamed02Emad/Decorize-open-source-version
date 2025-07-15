List<ImageModel> imagesFromJson(List<dynamic> json) {
  return json.map((e) => ImageModel.fromJson(e)).toList();
}
class ImageModel {
  int id;
  String url;

  ImageModel({
    required this.id,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'] ?? json['image'],
    );
  }
}
