import 'package:decorizer/common/constant/app_images.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';

enum UserType {
  user,
  worker;

  factory UserType.fromString(String type) {
    switch (type) {
      case 'client':
      case 'user':
        return UserType.user;
      case 'worker':
        return UserType.worker;
      default:
        throw Exception('Unknown user type');
    }
  }

  String get displayName => switch (this) {
        UserType.user => LocaleKeys.common_user,
        UserType.worker => LocaleKeys.common_worker,
      };

  String get image => switch (this) {
        UserType.user => AppImages.user,
        UserType.worker => AppImages.worker,
      };

  String get apiName => switch (this) {
        UserType.user => 'client',
        UserType.worker => 'worker',
      };

  bool get isClient => this == UserType.user;
  bool get isWorker => this == UserType.worker;
}
