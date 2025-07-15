

class GetWorkerProfileParams {
  int workerId;

  GetWorkerProfileParams({required this.workerId});
  Map<String, dynamic> toJson() => {
    'worker_id': workerId,
  };
}