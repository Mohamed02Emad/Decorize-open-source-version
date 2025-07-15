import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';

import '../../../offers/domain/Enum/worker_offer_state.dart';
import '../../../offers/domain/Enum/worker_order_details_status.dart';


List<WorkerOrderModel> ordersFromJson(List<dynamic> json) {
  return json.map((e) => WorkerOrderModel.fromJson(e)).toList();
}

class WorkerOrderModel {
  int id;
  String title;
  String content;
  String budget;
  int numberOfDays;
  DateTime createdAt;
  Map<String, dynamic> governorateId;
  Map<String, dynamic> cityId;
  String slug;
  double? lat;
  double? long;
  String? location;
  List<ImageModel> files;
  List<TypeModel> types;
  final WorkerOfferState? myOfferStatus;

  WorkerOrderModel({
    required this.id,
    required this.title,
    required this.content,
    required this.budget,
    required this.numberOfDays,
    required this.createdAt,
    required this.governorateId,
    required this.cityId,
    required this.slug,
    required this.lat,
    required this.long,
    required this.location,
    required this.files,
    required this.types,
    required this.myOfferStatus,
  });

  factory WorkerOrderModel.fromJson(Map<String, dynamic> json) {
    return WorkerOrderModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      budget: json['budget'],
      numberOfDays: json['number_of_days'],
      createdAt: DateTime.parse(json['created_at']),
      governorateId: json['governorate_id'],
      cityId: json['city_id'],
      slug: json['slug'],
      lat: json['lat']?.toString().toDouble(),
      long: json['long']?.toString().toDouble(),
      location: json['location']?.toString(),
      files: List<ImageModel>.from(
          json['files'].map((e) => ImageModel.fromJson(e))),
      types:
      List<TypeModel>.from(json['types'].map((e) => TypeModel.fromJson(e))),
      myOfferStatus: json['auth_user_status'] != null
          ? WorkerOfferState.fromString(json['auth_user_status'])
          : null,
    );
  }
}
