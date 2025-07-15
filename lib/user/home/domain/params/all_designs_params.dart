class AllDesignsParams {
  final int page;
  final int? categoryId;
  final String? query;

  AllDesignsParams({
    required this.page,
    this.categoryId,
    this.query,
  });
}
