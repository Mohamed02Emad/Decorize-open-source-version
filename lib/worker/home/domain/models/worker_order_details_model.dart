import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/shared_features/static/domain/models/city_model.dart';
import 'package:decorizer/shared_features/static/domain/models/governorate_model.dart';
import 'package:decorizer/shared_features/static/domain/models/type_model.dart';
import 'package:decorizer/worker/offers/domain/Enum/worker_offer_state.dart';
import '../../../offers/domain/Enum/worker_order_details_status.dart';
import '../../../offers/domain/models/user_model.dart';

class WorkerOrderDetailsModel {
  final int id;
  final String title;
  final String content;
  final String budget;
  final int numberOfDays;
  final GovernorateModel governorate;
  final CityModel city;
  final String slug;
  final double? lat;
  final double? long;
  final WorkerOrderDetailsStatus status;
  final List<ImageModel> files;
  final List<TypeModel> types;
  final List<dynamic> offers;
  final UserModel? owner;
  final DateTime? createdAt;
  final int acceptedOffersCount;
  final String? locationDescription;
  final WorkerOfferState? myOfferStatus;

  WorkerOrderDetailsModel({
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
    required this.offers,
    required this.owner,
    required this.createdAt,
    required this.acceptedOffersCount,
    required this.locationDescription,
    required this.myOfferStatus,
  });

  factory WorkerOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return WorkerOrderDetailsModel(
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
      status: WorkerOrderDetailsStatus.fromString(json['status']),
      files: List<ImageModel>.from(
          json['files'].map((e) => ImageModel.fromJson(e))),
      types:
      List<TypeModel>.from(json['types'].map((e) => TypeModel.fromJson(e))),
      offers: List<dynamic>.from(json['offers']['data'].map((e) => e)),
      createdAt: DateTime.parse(json['created_at']),
      owner: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      acceptedOffersCount: json['accepted_offers_count'] ?? 0,
      locationDescription: json['location'],
      myOfferStatus: json['auth_user_status'] != null
          ? WorkerOfferState.fromString(json['auth_user_status'])
          : null,
    );
  }

  WorkerOrderDetailsModel copyWith({
    int? id,
    String? title,
    String? content,
    String? budget,
    int? numberOfDays,
    GovernorateModel? governorate,
    CityModel? city,
    String? slug,
    double? lat,
    double? long,
    WorkerOrderDetailsStatus? status,
    List<ImageModel>? files,
    List<TypeModel>? types,
    List<dynamic>? offers,
    UserModel? owner,
    DateTime? createdAt,
    int? acceptedOffersCount,
    String? locationDescription,
  }) {
    return WorkerOrderDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      budget: budget ?? this.budget,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      slug: slug ?? this.slug,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      status: status ?? this.status,
      files: files ?? this.files,
      types: types ?? this.types,
      offers: offers ?? this.offers,
      owner: owner ?? this.owner,
      createdAt: createdAt ?? this.createdAt,
      acceptedOffersCount: acceptedOffersCount ?? this.acceptedOffersCount,
      locationDescription: locationDescription ?? this.locationDescription,
      myOfferStatus: myOfferStatus ?? this.myOfferStatus,
    );
  }
}
