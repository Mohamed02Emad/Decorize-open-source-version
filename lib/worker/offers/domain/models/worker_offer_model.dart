

import 'package:decorizer/worker/offers/domain/Enum/worker_offer_state.dart';
import 'package:decorizer/worker/offers/domain/models/post_model.dart';
import 'package:decorizer/worker/offers/domain/models/user_model.dart';


List<WorkerOfferModel> offersFromJson(List<dynamic> json) {
  return json.map((e) => WorkerOfferModel.fromJson(e)).toList();
}

class WorkerOfferModel {
  int id;
  String description;
  int budget;
  int numberOfDays;
  WorkerOfferState status;
  String? reason;
  UserModel user;
  PostModel post;
  DateTime createdAt;

  WorkerOfferModel({
    required this.id,
    required this.description,
    required this.budget,
    required this.numberOfDays,
    required this.status,
    required this.reason,
    required this.user,
    required this.post,
    required this.createdAt,
  });

  factory WorkerOfferModel.fromJson(Map<String, dynamic> json) {
    return WorkerOfferModel(
      id: json['id'],
      description: json['description'],
      budget: json['budget'],
      numberOfDays: json['number_of_days'],
      status:  WorkerOfferState.fromString(json['status']),
      user: UserModel.fromJson(json['user']),
      post: PostModel.fromJson(json['post']),
      reason: json['reason']?.toString(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
