import 'package:decorizer/worker/offers/domain/Enum/worker_order_details_status.dart';

import '../../../../shared_features/static/domain/models/type_model.dart';

class UserModel{
   int id;
   String? name;
   String? image;
   double? avgRating;
   String? profession;
   double? authUserRate;
   double? totalRates;


   UserModel({
     required this.id,
     required this.name,
     required this.image,
     required this.avgRating,
     required this.profession,
     required this.authUserRate,
     required this.totalRates,
   });

   factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
         id: json['id'],
         name: json['name'],
         image: json['image'] ?? '',
         avgRating: json['avg_rating'] ?? 0,
         profession: json['profession'],
         authUserRate: json['auth_user_rate']?.toDouble(),
         totalRates: json['total_rates']?.toDouble() ?? 0,
      );
   }
}