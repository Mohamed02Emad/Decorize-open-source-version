
import '../models/user.dart';

abstract class LocalRepository {

  bool finishedOnBoarding();

  User? getCachedUser();

  String? getUserAccessToken();
  //todo add use case if needed
  DateTime? getExpiresAt();
  void setExpiresAt(DateTime? time);

  void setUserAccessToken(String? token);

  void setCachedUser(User? user);

  void setFinishedOnBoarding(bool finishedOnboarding);

}