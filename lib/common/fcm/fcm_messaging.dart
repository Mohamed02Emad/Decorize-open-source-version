import 'dart:developer';
import 'dart:io';

import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../di/injection_container.dart' as di;
import 'local_notifications_service.dart';

abstract class FCMMessaging {
  static Future<void> setForegroundNotificationPresentationOptions() async {
    FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
    return await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<String?> getToken() async {
    if(Platform.isIOS){
    return "dummy token";
    }
    try {
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }



  static void onMessage(LocalNotificationService service) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      _refreshCounters();
      _showLocalNotification(service, event);
    });
  }

  static void onMessageOpenedApp(LocalNotificationService service) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      logEvent(event);
      _refreshCounters();
      _handleNotificationDirections(event);
    });
  }

  static void onBackgroundMessage(LocalNotificationService service) {
    FirebaseMessaging.onBackgroundMessage((message) async {
      logEvent(message);
      _showLocalNotification(service, message);
    });
  }

  static void getInitialMessage(LocalNotificationService service) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        logEvent(message);
        _handleNotificationDirections(message);
      }
    });
  }

  static void subscribeToTopic(String topic) {
    FirebaseMessaging.instance
        .subscribeToTopic(topic)
        .then((value) {})
        .catchError((error) {});
  }

  static void _showLocalNotification(
      LocalNotificationService service, RemoteMessage event) {
    String title = event.notification?.title ?? '';
    String body = event.notification?.body ?? '';
    if (Platform.isAndroid) {
      service.showNotification(id: 100, title: title, body: body);
    }
  }
}

 void _refreshCounters() {
    if(GuestUtil.isGuest) return;
    di.sl<UnreadMessageCountCubit>().getUnreadCount();
    di.sl<UnreadMessageCountCubit>().getUnreadCount();
  }

  void logEvent(RemoteMessage event) {
    log(event.data.toString());
  }


void _handleNotificationDirections(RemoteMessage message) {
  // final type = message.data["type"].toString();
  // if (type.contains("new_message")) {
  //   final chatId = int.parse(message.data["id"]);
  //   sl<AppNavigator>().push(screen: ChatScreen(chatId: chatId));
  // } else if (type.contains("order")) {
  //   final orderId = int.parse(message.data["id"]);
  //   sl<AppNavigator>().push(
  //       screen: MyOrderDetailsScreen(
  //     orderId: orderId,
  //   ));
  // } else {
  //   sl<AppNavigator>().push(screen: const NotificationsScreen());
  // }
}
