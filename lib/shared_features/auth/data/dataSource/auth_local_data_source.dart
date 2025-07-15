import 'package:injectable/injectable.dart';

import '../../../../common/data/preference/app_preferences.dart';
import '../../../../common/data/preference/item/preference_item.dart';
import '../../domain/models/user.dart';


abstract class AuthLocalDataSource {

  String? getUserAccessToken();

  DateTime? getExpiresAt();

  User? getCachedUser();

  bool finishedOnBoarding();

  void setUserAccessToken(String? token);

  void setExpiresAt(DateTime? time);

  void setCachedUser(User? user);

  void setFinishedOnBoarding(bool finishedOnboarding);

  void clearCache();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {

  AuthLocalDataSourceImpl();

  @override
  void setUserAccessToken(String? token) {
    PreferenceItem<String>(AppPreferences.accessToken, token ?? '')
        .set(token ?? '');
  }

  @override
  String? getUserAccessToken() {
    final token = PreferenceItem<String>(AppPreferences.accessToken, '').get();
    if (token.isEmpty) return null;
    return token;
  }

  @override
  void setExpiresAt(DateTime? time) {
    PreferenceItem<String>(AppPreferences.expiresAt, time.toString())
        .set(time.toString());
  }

  @override
  DateTime? getExpiresAt() {
    final time = PreferenceItem<String>(AppPreferences.expiresAt, '').get();
    if (time.isEmpty) return null;
    return DateTime.tryParse(time);
  }

  @override
  User? getCachedUser() {
    final userString =
        PreferenceItem<String>(AppPreferences.cachedUser, '').get();
    return userString.isEmpty ? null : User.fromCacheString(userString);
  }

  @override
  void setCachedUser(User? user) {
    PreferenceItem<String>(
            AppPreferences.cachedUser, user == null ? '' : user.toCacheString())
        .set(user == null ? '' : user.toCacheString());
  }

  @override
  bool finishedOnBoarding() =>
      PreferenceItem<bool>(AppPreferences.finishedOnBoarding, false).get();

  @override
  void setFinishedOnBoarding(bool finishedOnboarding) => PreferenceItem<bool>(
          AppPreferences.finishedOnBoarding, finishedOnboarding)
      .set(finishedOnboarding);

  @override
  void clearCache() {
    setCachedUser(null);
    setExpiresAt(null);
    setUserAccessToken(null);
  }
}
