import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/worker/profile/domain/models/gallery_model.dart';
import 'package:decorizer/worker/profile/domain/models/rate_model.dart';

class WorkerProfileModel {

  int id;
  String name;
  String profession;
  String? image;
  List<GalleryModel> gallery;
  Map<String, int> rateDestribution;
  double averageRate;
  int ratesCount;
  List<RateModel> rates;

  WorkerProfileModel({
    required this.id,
    required this.name,
    required this.profession,
    this.image,
    required this.gallery,
    required this.rateDestribution,
    required this.averageRate,
    required this.ratesCount,
    required this.rates,
  });

  factory WorkerProfileModel.fromJson(Map<String, dynamic> json) {
    return WorkerProfileModel(
      id: json['id'],
      name: json['name'],
      profession: json['profession'],
      image: json['image'],
      gallery: List<GalleryModel>.from(json['gallery'].map((e) => GalleryModel.fromJson(e))),
      rateDestribution: Map<String, int>.from(json['rate_distribution']),
      averageRate: json['avg_rate'],
      ratesCount: json['rates_count'],
      rates: List<RateModel>.from(
        json['rates'].map((e) => RateModel.fromJson(e)),
      ),
    );
  }

}