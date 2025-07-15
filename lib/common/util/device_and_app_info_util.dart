import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Singleton()
class DeviceAndAppInfoUtil {
  DeviceAndAppInfoUtil() {
    PackageInfo.fromPlatform().then(
      (result) {
        packageInfo = result;
      },
    );
  }

  late final PackageInfo packageInfo;

  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;

  String get packageName => packageInfo.packageName;
  String get appName => packageInfo.appName;

  String get appVersion => 'Version: $version ($buildNumber)';
}
