List<GalleryModel> imagesFromJson(List<dynamic> json) {
  return json.map((e) => GalleryModel.fromJson(e)).toList();
}
class GalleryModel {
  int id;
  String image;

  GalleryModel({
    required this.id,
    required this.image,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'],
      image: json['image'],
    );
  }
}
