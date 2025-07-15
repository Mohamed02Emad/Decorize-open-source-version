class GetNotificationsParams {
  final int page;

  GetNotificationsParams({required this.page});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }
}
