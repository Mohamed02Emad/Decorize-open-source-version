
class AddRateParams {
  int workerId ;
  int rate;
  String? comment;

  AddRateParams({required this.workerId, required this.rate, this.comment});

  Map<String, dynamic> toJson() {
    return {
      'worker_id': workerId,
       'rate': rate,
      'comment': comment ?? '',
    };
  }
}