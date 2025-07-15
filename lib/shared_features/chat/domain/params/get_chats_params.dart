class GetChatsParams {
  final int page;
  final String? query;

  GetChatsParams({required this.page, this.query});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (query != null && query!.isNotEmpty) 'search': query,
    };
  }
}
