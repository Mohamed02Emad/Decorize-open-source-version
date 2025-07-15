import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _service =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(notificationCategories: [
      DarwinNotificationCategory('basic_chanel', actions: [], options: {
        DarwinNotificationCategoryOption.hiddenPreviewShowSubtitle,
        DarwinNotificationCategoryOption.allowAnnouncement,
      }),
    ]);
    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _service.initialize(settings);
    await _service
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(sound: true, alert: true, badge: true);
  }

  Future<NotificationDetails> _notificationDetails(String? icon) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'basic_chanel',
      'basic_chanel',
      channelDescription: 'basic_chanel',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      icon: icon,
    );

    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? icon,
  }) async {
    final NotificationDetails details = await _notificationDetails(icon);
    await _service.show(id, title, body, details);
  }
}
