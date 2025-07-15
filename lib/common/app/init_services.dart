import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/fcm/fcm_messaging.dart';
import 'package:decorizer/common/fcm/local_notifications_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../firebase_options.dart';
import '../common.dart';

initServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseCrashlyticsService.run();
  final bool status = await Permission.notification.isPermanentlyDenied;
  final bool status2 = await Permission.notification.isDenied;

  if (status2 || status) {
    Permission.notification.request();
  }
  await EasyLocalization.ensureInitialized();
  // await ServiceLocator.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

initFCMServices() async {
  final LocalNotificationService localNotificationService =
      sl<LocalNotificationService>();
  await localNotificationService.init();
  FCMMessaging.setForegroundNotificationPresentationOptions();
  FCMMessaging.onMessage(localNotificationService);
  FCMMessaging.onMessageOpenedApp(localNotificationService);
  FCMMessaging.onBackgroundMessage(localNotificationService);
  FCMMessaging.getInitialMessage(localNotificationService);
  // await FCMMessaging.getToken();
  // FCMMessaging.onTokenRefresh();
  FCMMessaging.subscribeToTopic('all');
}
