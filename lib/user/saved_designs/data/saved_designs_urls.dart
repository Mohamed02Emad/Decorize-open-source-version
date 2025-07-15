class SavedDesignsUrls {
  static String savedDesigns(int page, String? query) {
    final queryParam = query != null ? '&query=$query' : '';
    return '/auth/generated-images?page=$page$queryParam';
  }
}
