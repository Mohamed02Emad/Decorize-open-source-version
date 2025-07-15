import 'package:decorizer/user/orders/domain/enums/offer_state.dart';
import 'package:decorizer/user/orders/domain/models/offer_user.dart';

List<OfferModel> offersFromJson(List<dynamic> json) {
  return json.map((e) => OfferModel.fromJson(e)).toList();
}

class OfferModel {
  final int id;
  final String description;
  final double budget;
  final int numberOfDays;
  final OfferState status;
  final OfferUser user;
  final DateTime createdAt;

  OfferModel({
    required this.id,
    required this.description,
    required this.budget,
    required this.numberOfDays,
    required this.status,
    required this.user,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as int,
      description: json['description'] as String,
      budget: (json['budget'] as num).toDouble(),
      numberOfDays: json['number_of_days'] as int,
      status: OfferState.fromString(json['status'] as String),
      user: OfferUser.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  OfferModel updateStatus(OfferState status,) {
    return copyWith(status: status);
  }

  OfferModel copyWith({
    OfferState? status,
    OfferUser? user,
    DateTime? createdAt,
    String? description,
    double? budget,
    int? numberOfDays,
  }) {
    return OfferModel(
      id: id,
      description: description ?? this.description,
      budget: budget ?? this.budget,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      status: status ?? this.status,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
