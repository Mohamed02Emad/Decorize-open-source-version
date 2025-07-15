import '../../../../user/orders/domain/enums/offer_state.dart';
import '../Enum/worker_order_details_status.dart';

class PostModel{
  int id;
  String title;
  String? image;
  WorkerOrderDetailsStatus? status;


  PostModel({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      status: WorkerOrderDetailsStatus.fromString(json['status']),
    );
  }
}