class EditProfileUrls {
  static const String updateProfile = '/auth/update-profile';
  static const String changePassword = '/auth/change-password';
  static String getProfile(String userId) => '/auth/profile?user_id=$userId';
}
