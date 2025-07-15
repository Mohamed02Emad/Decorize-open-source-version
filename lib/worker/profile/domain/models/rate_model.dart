import 'package:decorizer/worker/offers/domain/models/user_model.dart';

List<RateModel> imagesFromJson(List<dynamic> json) {
  return json.map((e) => RateModel.fromJson(e)).toList();
}
class RateModel {
  int id;
  String rate;
  String comment;
  UserModel user;
  DateTime createdAt;

  RateModel({
    required this.id,
    required this.rate,
    required this.comment,
    required this.user,
    required this.createdAt,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      rate: json['rate'],
      comment: json['comment'] ?? '',
      user: UserModel.fromJson(json['user']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
