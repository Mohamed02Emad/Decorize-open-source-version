import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/user/orders/domain/enums/order_details_state.dart';

List<OrderModel> ordersFromJson(List<dynamic> json) {
  return json.map((e) => OrderModel.fromJson(e)).toList();
}

class OrderModel {
  int id;
  String title;
  String content;
  String budget;
  int numberOfDays;
  GovernorateModel governorate;
  CityModel city;
  String slug;
  double? lat;
  double? long;
  OrderDetailsState status;
  List<ImageModel> files;
  List<TypeModel> types;

  OrderModel({
    required this.id,
    required this.title,
    required this.content,
    required this.budget,
    required this.numberOfDays,
    required this.governorate,
    required this.city,
    required this.slug,
    required this.lat,
    required this.long,
    required this.status,
    required this.files,
    required this.types,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      budget: json['budget'],
      numberOfDays: json['number_of_days'],
      governorate: GovernorateModel.fromJson(json['governorate_id']),
      city: CityModel.fromJson(json['city_id']),
      slug: json['slug'],
      lat: json['lat']?.toString().toDouble(),
      long: json['long']?.toString().toDouble(),
      status: OrderDetailsState.fromString(json['status']),
      files: List<ImageModel>.from(
          json['files'].map((e) => ImageModel.fromJson(e))),
      types:
          List<TypeModel>.from(json['types'].map((e) => TypeModel.fromJson(e))),
    );
  }
}
