class OrdersUrls {
  static const String getOrders = '/auth/posts';
  static  String getOrderById(String id) => '/auth/posts/$id';
  static String updateOrderStatus(String id) => '/auth/posts/update-status/$id';
  static String updateOrder(String id) => '/auth/posts/update/$id';
  static String deleteOrder(String id) => '/auth/posts/$id';
  static const String getOffers = '/auth/offers';
  static String updateOfferStatus(String id) => 'auth/offers/update-status/$id';
  static String addRate = '/auth/rates/store';
}
