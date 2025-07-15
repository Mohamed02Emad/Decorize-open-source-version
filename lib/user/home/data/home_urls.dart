class HomeUrls {
  static String suggestedDesigns(int categoryId) =>
      '/auth/categories/get-images?category_id=$categoryId';
  static String savedDesigns = '/auth/generated-images';
  static String allDesigns(int page, int? categoryId, String? query) {
    final categoryParam = categoryId != null ? '&category_id=$categoryId' : '';
    final queryParam = query != null ? '&query=$query' : '';
    return '/auth/categories/get-images?page=$page$categoryParam$queryParam';
  }
}
