import 'package:decorizer/shared_features/auth/data/dataSource/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/local_repository.dart';


@Injectable(as:LocalRepository)
class LocalRepositoryImpl extends LocalRepository {
  final AuthLocalDataSource dataSource;


  LocalRepositoryImpl(this.dataSource);

  @override
  bool finishedOnBoarding() => dataSource.finishedOnBoarding();

  @override
  User? getCachedUser() => dataSource.getCachedUser();

  @override
  String? getUserAccessToken() => dataSource.getUserAccessToken();

  @override
  DateTime? getExpiresAt() => dataSource.getExpiresAt();

  @override
  void setExpiresAt(DateTime? time) => dataSource.setExpiresAt(time);

  @override
  void setUserAccessToken(String? token) =>
      dataSource.setUserAccessToken(token);

  @override
  void setCachedUser(User? user) => dataSource.setCachedUser(user);

  @override
  void setFinishedOnBoarding(bool finishedOnboarding) =>
      dataSource.setFinishedOnBoarding(finishedOnboarding);
}
