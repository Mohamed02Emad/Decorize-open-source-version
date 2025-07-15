class StoreWorkerOffersParams{
  final int postId;
  final String budget;
  final String? description;
  final String numberOfDays;

  StoreWorkerOffersParams({
    required this.postId,
    required this.budget,
    this.description,
    required this.numberOfDays,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['budget'] = budget;
    data['description'] = description ?? '';
    data['number_of_days'] = numberOfDays;
    return data;
  }
}