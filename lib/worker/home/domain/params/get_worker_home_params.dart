class GetWorkerHomeParams {
  final int pageKey;

  GetWorkerHomeParams({required this.pageKey});

  Map<String, dynamic> toJson() => {'page': pageKey};
}
