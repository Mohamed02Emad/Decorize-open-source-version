class StaticUrls {
  static const String types = '/auth/get-types';
  static const String governorates = '/auth/get-governorates';
  static String cities(int governorateId) => '/auth/get-cities/$governorateId';
  static const String categories = '/auth/categories';
}
