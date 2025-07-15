import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:decorizer/common/data/preference/item/preference_item.dart';
import 'package:decorizer/common/di/injection_container.config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import '../data/preference/app_preferences.dart';
import '../fcm/local_notifications_service.dart';
import '../util/api_basehelper.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  sl.allowReassignment = true;
  // core
  await _injectSharedPreferences();
  await _initPrefs();
  await _injectPusher();
  _initFcm();
  sl.pushNewScope(init: (_) {
    sl.init();
  });
  await _afterInitialization();
}

Future<void> _initPrefs() async {
  await AppPreferences.init();
}

Future<void> _afterInitialization() async {
  await sl<LoginInfoCubit>().init();
}

void _initFcm() {
  sl.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
}

Future<void> _injectSharedPreferences() async {
  sl.registerLazySingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance());
}

Future<void> _injectPusher() async {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  //todo : add pusher key here
  await pusher.init(
    apiKey: "put yours here",
    cluster: "eu",
    onAuthorizer: (channelName, socketId, options) async {
      //todo : add pusher secret here
      const secret = 'put yours here';
      //todo : add pusher key here
      const key = 'put yours here';
      String signature;
      String authToken;

      signature = generatePrivateChannelSignature(
        socketId,
        channelName,
        secret,
      );
      authToken = '$key:$signature';
      return {"auth": authToken};
    },
    onError: (message, code, error) => log(message.toString()),
    onSubscriptionSucceeded: (v, d) {
      log(v.toString());
    },
  );
  sl.registerFactory<PusherChannelsFlutter>(() => pusher);
  await pusher.connect();
}

SharedPreferences get sharedPreferences => sl<SharedPreferences>();

ApiBaseHelper get dioHelper => sl<ApiBaseHelper>();

String? _getUserAccessToken() {
  final token = PreferenceItem<String>(AppPreferences.accessToken, '').get();
  if (token.isEmpty) return null;
  return token;
}

String generatePrivateChannelSignature(
    String socketId, String channelName, String secret) {
  final authString = '$socketId:$channelName';
  final hmacSha256 = Hmac(sha256, utf8.encode(secret));
  final digest = hmacSha256.convert(utf8.encode(authString));
  return digest.toString();
}

String generatePresenceChannelSignature(
    String socketId, String channelName, String userDataJson, String secret) {
  final authString = '$socketId:$channelName:$userDataJson';
  final hmacSha256 = Hmac(sha256, utf8.encode(secret));
  final digest = hmacSha256.convert(utf8.encode(authString));
  return digest.toString();
}
